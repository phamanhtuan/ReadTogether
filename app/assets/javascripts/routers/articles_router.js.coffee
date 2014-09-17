class ReadTogether.Routers.Articles extends Backbone.Router
	routes:
		'': 'index'
		'tag(/)(:tag)' : 'tagAction'
	initialize: =>
		@articles_collection = new ReadTogether.Collections.Articles()		
		@articles_view = new ReadTogether.Views.ArticlesIndex(collection: @articles_collection)
		$("#main-part").html(@articles_view.render().el)	
		@addingArticle_model = 	new ReadTogether.Models.AddingArticle()		
		addingArticle = new ReadTogether.Views.AddingArticle(model: @addingArticle_model)
		$("header").append(addingArticle.render().el)	
	index: =>	
		if typeof @articles_collection.tag == "undefined" || @articles_collection == ""
			@articles_collection.tag = ""
			@articles_collection.fetch({reset: true})
		else
			@articles_collection.page = 1
			@articles_collection.tag = ""
			@articles_collection.fetch({reset: true})
			
	tagAction: (tag) =>		
		if(typeof tag == "undefined" || tag == null)
			@navigate("", {trigger: true})
		else			
			@articles_collection.tag = decodeURI(tag)
			@articles_collection.fetch({reset: true})

