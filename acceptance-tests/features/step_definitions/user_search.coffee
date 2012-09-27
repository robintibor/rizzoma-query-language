spawn = require('child_process').spawn
exec = require('child_process').exec
cucumber_util = require('../support/cucumber_util')


stepDefinitions = () ->
    this.Given(/^a sphinx server without records$/, (callback) ->
        # remove all data from the server
        # first remove then fill only document schema so that sphinx can be searched
        removeProcess = spawn("#{cucumber_util.getSupportScriptsDirectory()}/clean_sphinx_index.sh")
        removeProcess.on('exit', (code) ->
            if (code == 0)
                cucumber_util.fillSphinxWithDocuments('', callback);
            else
                callback.fail("Removing records from sphinx (clean_sphinx_index.sh failed with code #{code}")
        )
    )
    
    failScenarioOrCallbackOnExit = (process, failMessage , callback) ->
        process.on('exit', (code) ->
                    if (code == 0)
                        callback()
                    else
                        callback.fail(failMessage + "code: #{code}")
                )
    
    this.Given(/^the sphinx server has (\d+) records for user (\d+)$/,
        (numberOfRecords, userId, callback) ->
            createSphinxDocXML = (docId, userId) ->
                return "<sphinx:document id=\"#{documentId}\">
                <title>title</title>
                <ptags>(#{userId})</ptags>
                </sphinx:document>"
                
            sphinxDocString = ""
            sphinxDocString +=  "#{createSphinxDocXML(documentId, userId)}\n" for documentId in [1..numberOfRecords]
            cucumber_util.fillSphinxWithDocuments(sphinxDocString, callback)
    )
    
    this.When(/^I search for any user$/, (callback) ->
        this.rizzomaQLSearcher.search('user:13', 
            cucumber_util.wrapUserNameInArray,
            (result) =>
                this.searchResult = result
                callback()
        )
    )
    
    this.When(/^I search for user (\d+)$/, (userId, callback) ->
        this.rizzomaQLSearcher.search("user:#{userId}",
            cucumber_util.wrapUserNameInArray,
            (result) =>
                this.searchResult = result
                callback()
        )
    )
        
    this.Then(/^I should get (\d+) Results$/, (resultLength, callback) ->
        if (this.searchResult.length == parseInt(resultLength))
            callback()
        else 
            callback.fail("Should have found #{resultLength} results,\n 
            instead got result: #{this.searchResult} with length #{this.searchResult.length}")
        )

module.exports = stepDefinitions