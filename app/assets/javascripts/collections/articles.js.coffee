class ReadTogether.Collections.Articles extends PaginatedCollection
	url: ->
		"/api/articles"
	comparator: (article1, article2) ->
		article1.get('updated_at') < article2.get('updated_at')
	sync: (method, model, options) ->
	   	options || (options = {})
	   	params = null
	   	if(typeof @tag == "undefined" || @tag == "")
	   		params =$.param({page: this.page})
	   	else
	   		params =$.param({page: this.page, tag: @tag})
	   	if(method =='read')
	   		options.url = "/api/articles"+"?" + params
	   	else
	   		options.url = "/api/articles"
	   	Backbone.sync.apply(this, [method, model, options])
