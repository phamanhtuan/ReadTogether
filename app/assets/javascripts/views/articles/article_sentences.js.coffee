class ReadTogether.Views.ArticleSentences extends Backbone.View  
	template: JST['articles/sentences']	
	className: 'panel panel-success'
		
	initialize: ->
		@collection.on('reset', @render, this)	

	render: ->		
		sentences = []
		$(@el).html(@template(sentences: @collection))
		@$('span.function-btn').tooltip({ 'trigger': 'hover', 'placement': 'top'})
		@
