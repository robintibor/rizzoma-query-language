mysql = require('mysql')
SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

exports.testTagSearchConverter = (test)->
  expectedResult = "match('@gtags hallo')"
  query= "hallo"
  test.equal(sphinxQLConverter.generateTagQueryString(query), expectedResult)
  test.done()

exports.testTagSearchConverterWithZeroString = (test)->
  expectedResult = ""
  query= ""
  test.equal(sphinxQLConverter.generateTagQueryString(""), expectedResult)
  test.done()
exports.testConvertStringQueryToSphinxQlQuery = (test)->
  queryString = "#tag1 \"phrase1 phrase2\" word "
  expectedResult = "select * from #{indexName} where match('@gtags tag1') and match('@title \"phrase1 phrase2\"') " +
                                               "and match('@content \"phrase1 phrase2\"') " +
                                               "and match('@title word') " +
                                               "and match('@content word')"
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithZeroString  = (test)->
  queryString = ""
  expectedResult = ""
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()

exports.testConvertStringQueryToSphinxQlQueryWithPhrase = (test)->
  queryString = "'one two three'"
  expectedResult = "select * from #{indexName} where match('@title \"one two three\"') " +
                                                "and match('@content \"one two three\"')"
  test.equal(sphinxQLConverter.convertStringQueryToSphinxQlQuery(queryString), expectedResult)
  test.done()