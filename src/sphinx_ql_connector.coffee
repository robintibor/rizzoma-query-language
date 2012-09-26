mysql = require('mysql')

class SphinxQLConnector
    mySQLConnection = null
    constructor: ->
        mySQLConnection = mysql.createConnection({
          host     : 'localhost',
          port     : 9306
        })

    query: (queryString, queryReplacementStrings, callback) ->
        mySQLConnection.query(queryString, queryReplacementStrings, callback)
        
    close: (callback) ->
            mySQLConnection.query(
                'FLUSH RTINDEX rtwiki'
                (err, info)->
                    if (err) then throw err
                    console.log('Done, closing Sphinx Connection.')
                    mySQLConnection.end(callback)
                )
exports.SphinxQLConnector = SphinxQLConnector