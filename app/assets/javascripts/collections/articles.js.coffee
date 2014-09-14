class ReadTogether.Collections.Articles extends PaginatedCollection
	url: ->
		"/api/articles"
	comparator: (article1, article2) ->
		article1.get('updated_at') < article2.get('updated_at')
	sync: (method, model, options) ->
	   	options || (options = {})
	   	console.log( method)
	   	if(method =='read')
	   		options.url = "/api/articles"+"?" + $.param({page: this.page})
	   	else
	   		options.url = "/api/articles"
	   	Backbone.sync.apply(this, [method, model, options])
