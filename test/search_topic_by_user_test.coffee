SphinxQLConverter = require('../src/sphinx_ql_converter').SphinxQLConverter

indexName = 'index_delta_dev'
sphinxQLConverter = new SphinxQLConverter(indexName)

userNameIsValid = (userName) ->
    return parseInt(userName) >= 0

convertUserNameToPTags = (userName) ->
    if (userNameIsValid(userName))
        return [userName, userName + userName]
    else
        return null

exports.testConditionForUserIdZero = (test) -> 
    test.expect(1)
    testUserSphinxQLString('0', "ptags IN (0,00)", test)
    test.done()

exports.testConditionForInvalidUser = (test) -> 
    test.expect(1)
    testUserSphinxQLString('-1', 'ptags = -1', test)
    test.done()

testUserSphinxQLString = (userName, expectedCondition, test) ->
    whereCondition = sphinxQLConverter.generateConditionForUserId(
        userName,
        convertUserNameToPTags)
    test.equal(whereCondition, expectedCondition,
        "condition for user #{userName} should be #{expectedCondition}")