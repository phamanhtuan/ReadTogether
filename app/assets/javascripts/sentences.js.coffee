window.ReadTogether =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->  	
  	Backbone.pubSub = _.extend({}, Backbone.Events)
  	new ReadTogether.Routers.Sentences()  	
  	Backbone.history.start({pushState: true})
$(document).ready ->
  ReadTogether.initialize()  
