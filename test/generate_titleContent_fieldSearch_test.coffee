mysql = require('mysql')
SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

convertUserNameToUserId = (userName) ->
  return userName

# Tasting of generateTitleContentFieldSearchString

exports.testGenerateTitleContentFieldSearchString = (test)->
  expectedResult = " @(title,content) searchword"
  query = "searchword"
  test.equal(sphinxQLConverter.generateTitleContentFieldSearchString(query), expectedResult)
  test.done()

exports.testGenerateTitleContentFieldSearchStringWithZeroString = (test)->
  expectedResult = ""
  query = ""
  test.equal(sphinxQLConverter.generateTitleContentFieldSearchString(query), expectedResult)
  test.done()

exports.testGenerateTitleContentFieldSearchStringWithPhrase = (test)->
  expectedResult = " @(title,content) 'one two three'"
  query = "'one two three'"
  test.equal(sphinxQLConverter.generateTitleContentFieldSearchString(query), expectedResult)
  test.done()

exports.testGenerateTitleContentFieldSearchStringCombinedWithPhraseAndWords = (test)->
  expectedResult = " @(title,content) word1 'one two three' word2"
  query = "word1 'one two three' word2"
  test.equal(sphinxQLConverter.generateTitleContentFieldSearchString(query), expectedResult)
  test.done()