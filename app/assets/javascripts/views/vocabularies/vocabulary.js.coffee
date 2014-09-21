class ReadTogether.Views.Vocabulary extends Backbone.View
	template: JST['vocabularies/vocabulary']
	className: 'panel panel-default'
	initialize: ->
		Backbone.pubSub.on('clickOnWord', @clickWordOnEvent)	

	clickWordOnEvent: (options) =>
		if(typeof @model.get('word') == "undefined")
			return
		word = options.word.replace('.', '').replace('?', '').replace('!', '')
		if(@model.get('word') == word)
			@$('.collapse').addClass('in')
			$(@el).show()
		else
			@$('.collapse').removeClass('in')
			$(@el).hide()

	render: ->
		$(@el).html(@template(vocab: @model))
		@