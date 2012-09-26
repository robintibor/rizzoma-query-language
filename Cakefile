fs = require 'fs'

{print} = require 'sys'
{spawn} = require 'child_process'
exec = require('child_process').exec


build = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'lib', 'src']
  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()
  coffee.stdout.on 'data', (data) ->
    print data.toString()
  coffee.on 'exit', (code) ->
    callback?() if code is 0

runJitter = (argumentsForJitter) ->
    jitter = spawn 'jitter', argumentsForJitter
    jitter.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    jitter.stdout.on 'data', (data) ->
      print data.toString()

task 'build', 'Build lib/ from src/', ->
  build()

task 'auto-compile-and-test', 'compile src and test on changes, run test on changes', ->
    runJitter(['src', 'lib', 'test']) 

task 'auto-compile', 'compiles src and test on changes wihtout running tests', ->
    runJitter(['src', 'lib'])
    runJitter(['test', 'test'])
  
task 'run-acceptance-tests', 'runs the acceptance tests', ->
    cucumberTask = spawn('cucumber.js', ['-f', 'pretty', 'acceptance-tests/'],
    { 
        env: {'NODE_PATH': '/usr/lib/nodejs:/usr/share/javascript:/usr/lib/node_modules'}
    })
    cucumberTask.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    cucumberTask.stdout.on 'data', (data) ->
      print data.toString()

option '', '--inputfile [Filename]', 'Filename tof wikipedia xml input file...'
task 'run-perf', 'run performance test for searching and inserting', (options) ->
    insertTask = spawn('node', ['lib/startInserting.js', options['inputfile']])
    insertTask.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    insertTask.stdout.on 'data', (data) ->
      print data.toString()
    process.stdin.pipe(insertTask.stdin)
    searchTask = spawn('node', ['lib/performanceTestSearcher.js', options['inputfile']])
    searchTask.stderr.on 'data', (data) ->
      process.stderr.write data.toString()
    searchTask.stdout.on 'data', (data) ->
      print data.toString()
    process.stdin.pipe(searchTask.stdin)
            
    
    