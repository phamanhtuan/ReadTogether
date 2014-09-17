class ReadTogether.Routers.Sentences extends Backbone.Router
	routes:
		'article/:article_id': 'index'
		
	index: (article_id) ->		
		@sentences_collection = new ReadTogether.Collections.Sentences({article_id: article_id})
		@sentences_collection.fetch({reset: true})
		@slide_sentence_model = new ReadTogether.Models.SlideSentence()
		@comments_collection = new ReadTogether.Collections.Comments()
		# @comments_collection.fetch({reset: true})	
		@addingArticle_model = 	new ReadTogether.Models.AddingArticle()		
		sentences = new ReadTogether.Views.SentencesIndex(collection: @sentences_collection)		
		$("#article").html(sentences.render().el)
		comments = new ReadTogether.Views.CommentsIndex(collection: @comments_collection)
		$("#comment-body").html(comments.render().el)
		addingArticle = new ReadTogether.Views.AddingArticle(model: @addingArticle_model)
		$("header").append(addingArticle.render().el)
		slideSentenceView = new ReadTogether.Views.SlideSentence(model: @slide_sentence_model)
		$("#slide-sentence").html(slideSentenceView.render().el)

