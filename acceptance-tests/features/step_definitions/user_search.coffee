spawn = require('child_process').spawn
exec = require('child_process').exec
RizzomaQLSearcher = require('../../../lib/rizzoma_ql_searcher').RizzomaQLSearcher

acceptanceTestDirectory = '/home/robintibor/work/rizzoma-query-language/acceptance-tests/'

stepDefinitions = () ->
    this.Given(/^a sphinx server without records$/, (callback) ->
        # remove all data from the server
        # first remove then fill only document schema so that sphinx can be searched
        removeProcess = spawn(acceptanceTestDirectory + 'features/support/clean_sphinx_index.sh')
        removeProcess.on('exit', (code) ->
            if (code == 0)
                fillProcess = spawn(acceptanceTestDirectory + 'features/support/fill_sphinx_index.sh', [''])
                failScenarioOrCallbackOnExit(fillProcess, "Filling Sphinx Schema failed", callback)
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
    
    this.Given(/^a sphinx server with (\d+) records for user (\d+)$/,
        (numberOfRecords, userId, callback) ->
            createSphinxDocXML = (docId, userId) ->
                return "<sphinx:document id=\"#{documentId}\">
                <title>title</title>
                <ptags>(#{userId})</ptags>
                </sphinx:document>"
                
            sphinxDocString = ""
            sphinxDocString +=  "#{createSphinxDocXML(documentId, userId)}\n" for documentId in [1..numberOfRecords]
            fillProcess = spawn(acceptanceTestDirectory + 'features/support/fill_sphinx_index.sh', [sphinxDocString])
            failScenarioOrCallbackOnExit(fillProcess, "Filling Sphinx Indexer with #{sphinxDocString} failed", callback)
    )
    
    this.When(/^I search for any user$/, (callback) ->
        this.rizzomaQLSearcher.search('user:13', (result) =>
            this.searchResult = result
            callback()
        )
    )
    
    this.When(/^I search for user (\d+)$/, (userId, callback) ->
        this.rizzomaQLSearcher.search("user:#{userId}", (result) =>
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