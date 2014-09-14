window.ReadTogether =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
  	Backbone.pubSub = _.extend({}, Backbone.Events)
  	new ReadTogether.Routers.Articles()  	
  	Backbone.history.start()
$(document).ready ->
  ReadTogether.initialize()  
