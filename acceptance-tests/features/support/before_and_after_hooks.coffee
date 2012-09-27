RizzomaQLSearcher = require('../../../src/rizzoma_ql_searcher').RizzomaQLSearcher
myAroundHooks = () ->
    this.Around((runScenario) ->
        
        this.rizzomaQLSearcher = new RizzomaQLSearcher()
        # First do the "before scenario" tasks:
        runScenario((callback) ->
            this.rizzomaQLSearcher.close(callback)
        )
    )

module.exports = myAroundHooks