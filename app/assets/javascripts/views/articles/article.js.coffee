class ReadTogether.Views.Article extends Backbone.View  
	template: JST['articles/article']	

	events: 
		'click .function-btn.edit-btn': 'editArticle'
		'click #save-btn': 'editArticleSubmit'

	editArticleSubmit: (event)->					
		attribute = {content: @$('#content-box').val()}
		@model.save(attribute, 
			wait: true
			success: @successfulUpdate
			error:  @handleError	
		)

	successfulUpdate: (model, response) =>
		$("#editArticleModal").modal('hide')
		$('body').removeClass('modal-open')
		$('.modal-backdrop').remove()
	
	handleError: (model, response) =>	
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				console.log "#{attribute} of article #{message}" for message in messages	
				@$("#content-box").focus()			

	editArticle: (event) =>
		header = ""
		body = []
		body_final = []
		paragraph_id = 1
		for sentence in @sentencesCollection.models
			if (typeof body[sentence.get('paragraph')] == 'undefined')
				body[sentence.get('paragraph')] = []				
			body[sentence.get('paragraph')].push(sentence.get('content'))
		for paragraph in body
			body_final.push(paragraph.join(" "))
		$("#editArticleModal #content-box").val(body_final.join("\n"))
		$("#editArticleModal").modal('show')
		
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

	deleteArticle: =>
		console.log('test')
		@model.destroy()
