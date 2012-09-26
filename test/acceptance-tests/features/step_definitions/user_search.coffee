spawn = require('child_process').spawn
RizzomaQLSearcher = require('../../../../lib/rizzoma_ql_searcher').RizzomaQLSearcher
rizzomaQLSearcher = new RizzomaQLSearcher()

stepDefinitions = () ->

    this.Given(/^a sphinx server without records$/, (callback) ->
        # remove all data from the server
        removeProcess = spawn('features/support/clean_sphinx_index.sh')
        removeProcess.on('exit', (code) ->
            if (code == 0)
                fillProcess = spawn('features/support/fill_sphinx_schema.sh')
                fillProcess.on('exit', (code) ->
                    if (code == 0)
                        callback()
                    else
                        callback.fail("Filling Sphinx Schema failed with code #{code}")
                )
            else
                callback.fail("Removing records from sphinx (clean_sphinx_index.sh failed with code #{code}")
        )
    )

    this.When(/^I search for any user$/, (callback) ->
        rizzomaQLSearcher = new RizzomaQLSearcher()
        rizzomaQLSearcher.search('user:13', (result) =>
            this.searchResult = result;
            callback()
        )
    )

    this.Then(/^I should get (\d+) Results$/, (resultLength, callback) ->
        if (this.searchResult.length == 0)
            callback()
        else 
            callback.fail("should have not found any results, instead got #{result}")
        )

module.exports = stepDefinitions