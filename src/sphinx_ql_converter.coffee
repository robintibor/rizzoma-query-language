class SphinxQLConverter
    indexName = null
    
    constructor: (sphinxIndexName) ->
        indexName = sphinxIndexName
    
    generateSphinxQLString: (rizzomaQLString) ->
        # For now just dummy for user search
        userName = rizzomaQLString.split(':')[1]
        ptagCondition = @generateConditionForUserId(userName, (userString) ->
            if (parseInt(userString) >= 0)
                return [userString, userString + userString]
            else
                return null
            )
        return "SELECT * FROM #{indexName} WHERE #{ptagCondition}"  
    
    generateConditionForUserId: (userName, convertUserNameToPTags) ->
        pTags = convertUserNameToPTags(userName)
        if (pTags?)
            return "ptags IN (#{pTags})"
        else
            return "ptags = -1"

exports.SphinxQLConverter = SphinxQLConverter