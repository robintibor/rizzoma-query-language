mysql = require('mysql')
doubled = require('/home/ikset/rizzoma/rql/rizzoma-query-language/src/sphinxQlConverter');
#mySQLConnection = null
mySQLConnection = mysql.createConnection({
  host     : 'localhost',
  port     : 9306
})
exports[tagSearch] = (test)->
  qlConverter = new sphinxQlConverter();
  rightResult = "select * from index_delta_dev where match('@gtags sadlgjaslgj');"

  test.equal(qlConverter.getSqlString(), rightResult)
  test.done()

