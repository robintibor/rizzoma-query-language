class SphinxQLConverter
    indexName = null
    
    constructor: (sphinxIndexName) ->
        indexName = sphinxIndexName
    
    generateConditionForUserId: (userName, convertUserNameToPTags) ->
        pTags = convertUserNameToPTags(userName)
        if (pTags?)
            return "ptags IN (#{pTags})"
        else
            return "ptags = -1"

    generateTagQueryString: (queryString) ->
      if (queryString == null || queryString == '')
        return "";
      else
        return "match('@gtags #{queryString}')"

    generateContentQueryString: (queryString) ->
      if (queryString == null || queryString == '')
        return ""
      else
        return "match('@content #{queryString}')"

    generateTitleQueryString: (queryString) ->
      if (queryString == null || queryString == '')
        return ""
      else
        return "match('@title #{queryString}')"

    convertStringQueryToSphinxQlQuery: (queryString)->
      queryString = queryString.trim()
      queryString = queryString.replace(/\'/g, '"')
      queryWords = queryString.split(" ")
      tagWord = "#"
      userWord = "user:"
      index = 0;
      sqlString = ""
      while (index < queryWords.length)
        sqlWord = ""

        # case tag-search
        if (queryWords[index].indexOf('#', 0) == 0)
          sqlWord = this.generateTagQueryString(queryWords[index].substring(tagWord.length, queryString.length))

        # case user-search
        else if (queryWords[index].indexOf("user:", 0) == 0)
          sqlWord = this.generateConditionForUserId(queryWords[index].substring(userWord.length, queryString.length),
                                     (userName) -> userName) #TODO: rightfunction
        # case phrase-search
        else if (queryWords[index].indexOf("\"", 0) == 0)
          phrase="";
          while (index < queryWords.length && queryWords[index].indexOf("\"", 0) !=  queryWords[index].length-1)
            phrase += queryWords[index] + " "
            index++
          if (index < queryWords.length)
            phrase += queryWords[index] + " "
          phrase = phrase.substring(0,phrase.length-1)
          sqlWord = this.generateTitleQueryString(phrase)
          sqlWord += " and " + this.generateContentQueryString(phrase)

        # case simple-search
        else if (sqlString.length > 1)
          sqlWord = this.generateTitleQueryString(queryWords[index])
          sqlWord += " and " + this.generateContentQueryString(queryWords[index])

        if (sqlString.length > 1)
          sqlString += " and " + sqlWord
        else
          sqlString += sqlWord

        index++

      if (sqlString.length == 0)
        return ""
      else
        return "select * from #{indexName} where #{sqlString}"



  exports.SphinxQLConverter = SphinxQLConverter
