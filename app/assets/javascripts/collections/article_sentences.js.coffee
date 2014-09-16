class ReadTogether.Collections.ArticleSentences extends Backbone.Collection
	article_id: -1
	
	url: ->"/api/articles/"+@article_id+"/sentences"
	initialize: (options) ->			
		@article_id = options.article_id 

	# sync: (method, model, options) ->
 #    	options || (options = {})
 #    	options.url = "/api/articles/"+@article_id+"/sentences"	
 #    	Backbone.sync.apply(this, [method, model, options])
