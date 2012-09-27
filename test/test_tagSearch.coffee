mysql = require('mysql')
SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

exports.testTagSearchConverter = (test)->
  expectedResult = " @gtags hallo"
  query= "hallo"
  test.equal(sphinxQLConverter.gengenerategTagFieldSearchString(query), expectedResult)
  test.done()

exports.testTagSearchConverterWithZeroString = (test)->
  expectedResult = ""
  query = ""
  test.equal(sphinxQLConverter.gengenerategTagFieldSearchString(""), expectedResult)
  test.done()
exports.testConvertStringQueryToSphinxQlQuery = (test)->
  queryString = "#tag1 \"phrase1 phrase2\" word "
  expectedResult = "select * from #{indexName} where match(' @gtags tag1 @(title, content) \"phrase1 phrase2\" word')"
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithZeroString  = (test)->
  queryString = ""
  expectedResult = ""
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithPhrase = (test)->
  queryString = "'one two three'"
  expectedResult = "select * from #{indexName} where match(' @(title, content) \"one two three\"')";
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()