acceptanceTestDirectory = '/home/robintibor/work/rizzoma-query-language/acceptance-tests/'
spawn = require('child_process').spawn

failScenarioOrCallbackOnExit = (process, failMessage , callback) ->
        process.on('exit', (code) ->
                    if (code == 0)
                        callback()
                    else
                        callback.fail(failMessage + "code: #{code}")
        )

fillSphinxWithDocuments = (sphinxDocumentsString, callback) ->
    fillScriptName = acceptanceTestDirectory + 'features/support/fill_sphinx_index.sh'
    fillProcess = spawn(fillScriptName,
        [sphinxDocumentsString])
    failScenarioOrCallbackOnExit(fillProcess,
        "Filling Sphinx Indexer with #{sphinxDocumentsString} failed",
        callback)        

wrapUserNameInArray = (userName) ->
    return [userName]

exports.failScenarioOrCallbackOnExit = failScenarioOrCallbackOnExit
exports.fillSphinxWithDocuments = fillSphinxWithDocuments
exports.wrapUserNameInArray = wrapUserNameInArray