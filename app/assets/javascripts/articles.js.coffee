window.ReadTogether =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
  	Backbone.pubSub = _.extend({}, Backbone.Events)
  	@router = new ReadTogether.Routers.Articles()  	
  	Backbone.history.start(pushState:true)
$(document).ready ->
  ReadTogether.initialize()  
