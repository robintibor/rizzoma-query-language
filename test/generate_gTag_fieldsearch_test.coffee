mysql = require('mysql')
SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

convertUserNameToUserId = (userName) ->
  return userName

# Tasting of tagSearchConverter

exports.testGenerategTagFieldSearchString = (test)->
  expectedResult = " @gtags hallo"
  query= "hallo"
  test.equal(sphinxQLConverter.generategTagFieldSearchString(query), expectedResult)
  test.done()

exports.testGenerategTagFieldSearchStringWithZeroString = (test)->
  expectedResult = ""
  query = ""
  test.equal(sphinxQLConverter.generategTagFieldSearchString(""), expectedResult)
  test.done()