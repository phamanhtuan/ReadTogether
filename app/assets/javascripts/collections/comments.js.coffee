class ReadTogether.Collections.Comments extends PaginatedCollection
	article_id: -1
	url: ->
		"/api/articles/"+@article_id+"/sentences/"+@sentence_id+"/comments" 
	comparator: (comment1, comment2) ->
		comment1.get('updated_at') < comment2.get('updated_at')
	sync: (method, model, options) ->
	   	options || (options = {})
	   	console.log( method)
	   	if(method =='read')
	   		options.url = "/api/articles/"+@article_id+"/sentences/"+@sentence_id+"/comments" +"?" + $.param({page: this.page})
	   	else
	   		options.url = "/api/articles/"+@article_id+"/sentences/"+@sentence_id+"/comments" 
	   	Backbone.sync.apply(this, [method, model, options])
