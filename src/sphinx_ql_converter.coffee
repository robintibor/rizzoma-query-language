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

    gengenerategTagFieldSearchString: (queryString) ->
      if (queryString == null || queryString == '')
        return "";
      else
        return " @gtags #{queryString}"

    generateTitleContentFieldSearchString: (queryString) ->
      if (queryString == null || queryString == '')
        return ""
      else
        return " @(title,content) #{queryString}"

    convertStringQueryToSphinxQlQuery: (queryString)->
      queryString = queryString.trim()
      queryString = queryString.replace(/\'/g, '"')
      queryWords = queryString.split(" ")

      # controlnames in query
      tagWord = "#"
      userWord = "user:"
      phraseWord = "\""

      # searchStrings for different fields
      # for Example: titleContentFieldString contains all words and phrases from queryString
      # for searching in title and content fields
      titleContentFieldString = ""
      pTagsFieldString = ""
      gTagsFieldString = ""

      index = 0;
      while (index < queryWords.length)

        # case tag-search
        if (queryWords[index].indexOf(tagWord, 0) == 0)
          gTagsFieldString += " " + queryWords[index].substring(tagWord.length, queryString.length)

        # case user-search
        else if (queryWords[index].indexOf(userWord, 0) == 0)
          pTagsFieldString = queryWords[index].substring(userWord.length, queryString.length)

        # case phrase-search
        else if (queryWords[index].indexOf(phraseWord, 0) == 0)
          phrase = "";
          while (index < queryWords.length && queryWords[index].indexOf(phraseWord, 0) !=  queryWords[index].length-1)
            phrase += queryWords[index] + " "
            index++
          if (index < queryWords.length)
            phrase += queryWords[index] + " "
          phrase = phrase.substring(0,phrase.length-1)
          titleContentFieldString += " " + phrase

        # case simple-search
        else if (queryWords[index].length > 1)
          titleContentFieldString += " " + queryWords[index]

        index++

      # summirize all tagFieldStrings to oresult sqlString
      sqlString = ""
      if (gTagsFieldString.length != 0)
        sqlString = this.gengenerategTagFieldSearchString(gTagsFieldString.substring(1, gTagsFieldString.length))
      if (titleContentFieldString.length != 0)
        sqlString += this.generateTitleContentFieldSearchString(titleContentFieldString.substring(1,
                                                                                titleContentFieldString.length))
      if (sqlString.length!= 0)
        sqlString = "match('" + sqlString + "')"
      if (pTagsFieldString.length != 0)
        if (sqlString.length!=0)
          sqlString+=" and "
        sqlString += this.generateConditionForUserId(pTagsFieldString, (pTagsFieldString)-> return pTagsFieldString)
                                                                                            #TODO: rightfuntction
      if (sqlString.length == 0)
        return ""
      else
        return "select * from #{indexName} where #{sqlString}"



  exports.SphinxQLConverter = SphinxQLConverter
