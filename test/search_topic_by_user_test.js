(function() {
  var SphinxQLConverter, convertUserNameToPTags, indexName, sphinxQLConverter, testUserSphinxQLString, userNameIsValid;

  SphinxQLConverter = require('../lib/sphinx_ql_converter').SphinxQLConverter;

  indexName = 'index_delta_dev';

  sphinxQLConverter = new SphinxQLConverter(indexName);

  userNameIsValid = function(userName) {
    return parseInt(userName) >= 0;
  };

  convertUserNameToPTags = function(userName) {
    if (userNameIsValid(userName)) {
      return [userName, userName + userName];
    } else {
      return null;
    }
  };

  exports.testConditionForUserIdZero = function(test) {
    test.expect(1);
    testUserSphinxQLString('0', "ptags IN (0,00)", test);
    return test.done();
  };

  exports.testConditionForInvalidUser = function(test) {
    test.expect(1);
    testUserSphinxQLString('-1', 'ptags = -1', test);
    return test.done();
  };

  testUserSphinxQLString = function(userName, expectedCondition, test) {
    var whereCondition;
    whereCondition = sphinxQLConverter.generateConditionForUserId(userName, convertUserNameToPTags);
    return test.equal(whereCondition, expectedCondition, "condition for user " + userName + " should be " + expectedCondition);
  };

}).call(this);
