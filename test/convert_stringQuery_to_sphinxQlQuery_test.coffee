mysql = require('mysql')
SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

convertUserNameToUserId = (userName) ->
  return userName

# Tasting of convertStringQueryToSphinxQlQuery

exports.testConvertStringQueryToSphinxQlQuery = (test)->
  queryString = "#tag1 \"phrase1 phrase2\" word "
  expectedResult = "select * from #{indexName} where match(' @gtags tag1 @(title,content) \"phrase1 phrase2\" word')"
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString, convertUserNameToUserId), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithZeroString  = (test)->
  queryString = ""
  expectedResult = ""
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString, convertUserNameToUserId), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithPhrase = (test)->
  queryString = "'one two three'"
  expectedResult = "select * from #{indexName} where match(' @(title,content) \"one two three\"')";
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString, convertUserNameToUserId), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithSingleWord = (test)->
  queryString = "searchword"

  expectedResult = "select * from #{indexName} where match(' @(title,content) searchword')";
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString, convertUserNameToUserId), expectedResult)
  test.done()