cucumber_util = require('../support/cucumber_util')

stepDefinitions = () ->
    this.Given(/^a sphinx engine with records:$/, (table, callback) ->
      sphinxDocumentsString = createSphinxDocStringFromTable(table)
      cucumber_util.fillSphinxWithDocuments(sphinxDocumentsString, callback)
    )
    createSphinxDocStringFromTable = (table) ->
        sphinxDocString = ""
        # Ids start from 0 but sphinx doc ids start from 1!
        sphinxDocString += createDocStringFromRow(row, id + 1) for row, id in table.hashes()
        return sphinxDocString    
        
    createDocStringFromRow = (row, id) ->
        sphinxDocString = "<sphinx:document id=\"#{id}\">"
        sphinxDocString += "<#{attribute}>#{value}</#{attribute}>"for attribute, value of row
        sphinxDocString += "</sphinx:document>"
        return sphinxDocString

    this.When(/^I search for "([^"]*)"$/, (query, callback) ->
        this.rizzomaQLSearcher.search(query, (result) =>
            this.searchResult = result
            callback()
        )
    )

    this.Then(/^I should find:$/, (table, callback) ->
        if (searchResultsEqual(table, this.searchResult))
            callback()
        else
            callback.fail("Search results not equal, got:
                #{JSON.stringify(this.searchResult)}, expected:
                #{JSON.stringify(table.hashes())}")
    )
    
    searchResultsEqual = (table, searchResult) ->
        if (table.hashes().length != searchResult.length)
            return false
        # Go through table and remember those results already used
        usedIds = {}
        for row in table.hashes()
            resultId = findCorrespondingSearchResult(row, searchResult, usedIds)
            if (resultId?)
                usedIds[resultId] = true
            else 
                return false
        return true
        
    findCorrespondingSearchResult = (row, searchResults, usedIds) ->
        for result, id in searchResults
            if not (usedIds[id] == true) && rowAndResultEqual(row, result)
                return id
        return null
        
    rowAndResultEqual = (row, result) ->
        ignoreProperties = {"parse":true, "_typeCast":true}
        for property, resultValue of result
            if ignoreProperties[property] == true
                continue
            if (not row[property]? && not propertyHasProperDefaultValue(property, resultValue))
                    return false;
            else if (row[property]? and row[property] != resultValue)
                return false
        return true
    
    propertyHasProperDefaultValue = (property, value) ->
        # id can be ignored if it wasnt set in expected result table.. weight the same
        if (property == 'id' or property == 'weight') 
            return true
        else
            return value == [] or value == '' or value == 0
    
module.exports = stepDefinitions