class ReadTogether.Routers.Articles extends Backbone.Router
	routes:
		'': 'index'
	initialize: ->
		@articles_collection = new ReadTogether.Collections.Articles()
		@articles_collection.fetch({reset: true})		
	index: ->	
		@articles_view = new ReadTogether.Views.ArticlesIndex(collection: @articles_collection)
		$("#main-part").html(@articles_view.render().el)	
		@addingArticle_model = 	new ReadTogether.Models.AddingArticle()		
		addingArticle = new ReadTogether.Views.AddingArticle(model: @addingArticle_model)
		$("header").append(addingArticle.render().el)

