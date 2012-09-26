class SphinxQLConverter
    indexName = null
    
    constructor: (sphinxIndexName) ->
        indexName = sphinxIndexName
    
    generateSphinxQLString: (rizzomaQLString) ->
        # For now just dummy for user search
        rizzomaQLString = 
    
    generateConditionForUserId: (userName, convertUserNameToPTags) ->
        pTags = convertUserNameToPTags(userName)
        if (pTags?)
            return "ptags IN (#{pTags})"
        else
            return "ptags = -1"

exports.SphinxQLConverter = SphinxQLConverter