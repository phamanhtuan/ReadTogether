class ReadTogether.Views.Article extends Backbone.View  
	template: JST['articles/article']	

	# events: 
	# 	'click .function-btn.delete-btn': 'deleteArticle'
		
	render: ->		
		$(@el).html(@template(sentences: @model))	
		@sentencesCollection = new ReadTogether.Collections.ArticleSentences({article_id: @model.get('id')})
		@sentencesCollection.fetch({reset: true})
		@sentencesView = new ReadTogether.Views.ArticleSentences(collection: @sentencesCollection)
		$(@el).append(@sentencesView.render().el)	
		@$('span.function-btn').tooltip({ 'trigger': 'hover', 'placement': 'top'})
		@$("div .delete-btn").confirm({
			text: "Are you sure you want to delete that article?",
			title: "Confirmation required",
			confirm: @deleteArticle,     
			cancel: -> console.log('cancel'),      
			confirmButton: "Yes I am",
			cancelButton: "No",
			post: true
		})
		@

	deleteArticle: ->
		console.log('test')
		@model.destroy()
