SphinxQLConnector = require('../lib/sphinx_ql_connector').SphinxQLConnector 
SphinxQLConverter = require('../lib/sphinx_ql_converter').SphinxQLConverter

class RizzomaQLSearcher
    sphinxQLConnector = null
    sphinxQLConverter = null
    
    constructor: ->
        sphinxQLConnector = new SphinxQLConnector()
        sphinxQLConverter = new SphinxQLConverter('index_delta_dev') # For now, hardcoded index name :)
        
    search: (searchString, callback) ->
        sphinxQLString = sphinxQLConverter.convertStringQueryToSphinxQlQuery(searchString)
        sphinxQLConnector.query(sphinxQLString, [], (err, result) ->
            if (err)
                console.log("Search for #{searchString} failed", JSON.stringify(err));
                throw err
            callback(result)
        )

    close: (callback) ->
        sphinxQLConnector.close(callback)

exports.RizzomaQLSearcher = RizzomaQLSearcher