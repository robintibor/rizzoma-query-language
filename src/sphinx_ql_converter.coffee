class SphinxQLConverter
    indexName = null
    
    constructor: (sphinxIndexName) ->
        indexName = sphinxIndexName
    
    
    generateConditionForUserId: (userName, convertUserNameToPTags) ->
        pTags = convertUserNameToPTags(userName);
        if (pTags?)
            return "ptags IN (#{pTags})"
        else
            return "ptags = -1"

exports.SphinxQLConverter = SphinxQLConverter