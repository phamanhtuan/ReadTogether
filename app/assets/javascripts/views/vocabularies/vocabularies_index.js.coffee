class ReadTogether.Views.VocabulariesIndex extends Backbone.View
	template: JST['vocabularies/index']
	className: 'panel-group vocabulary'
	events:
		'keydown #meaning-input': 'addVocab'
		'click .close-add-vocab-box': 'closeAddVocabBox'

	closeAddVocabBox: (event) =>
		@render()
	initialize: ->
		Backbone.pubSub.on('clickOnSentence', @getSentenceOnEvent)
		Backbone.pubSub.on('clickOnWord', @getWordOnEvent)
		@collection.on('reset', @render, this)	

	addVocab: (event) ->			
		if event.keyCode == 13
			event.preventDefault()
			word = @$("#word-input").val()
			if word.length == 0 
				@$("#word-input").focus()
				return
			meaning = @$("#meaning-input").val()
			if meaning.length == 0 
				@$("#meaning-input").focus()
				return
			attributes = {'word': word, meaning: meaning}			
			@collection.create(attributes,
			{
				wait: true
				success: @successfulUpdate
				error:  @handleError	
			})	
	successfulUpdate: (model, event) =>
		@collection.fetch({reset: true})

	handleError: (model, response) ->		
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				console.log "#{attribute} of comment #{message}" for message in messages	
				@$(".comment-edit-box").focus()			

	getWordOnEvent: (options) =>		
		word = options.word.replace('.', '').replace('?', '').replace('!', '')
		@$('#add-vocab').show()
		@$("#word-input").val(word)
		@$("#meaning-input").focus()
	getSentenceOnEvent: (options) =>
		@collection.sentence_id = options.sentence_id
		@collection.fetch({reset: true})
	render: ->
		$(@el).html(@template())	
		@$('#add-vocab').hide()	
		@collection.each(@renderVocab)
		@

	renderVocab: (vocab) =>
		if(vocab.get('translations').length == 0)
			return
		view = new ReadTogether.Views.Vocabulary(model: vocab)
		$(@el).append(view.render().el)
