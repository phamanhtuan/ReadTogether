class ReadTogether.Views.AddingArticle extends Backbone.View  
	template: JST['articles/add_article']
	events:
		'click #save-btn': 'createArticle'

	createArticle: (event)->		
		event.preventDefault()		
		attribute = {content: @$('#content-box').val()}
		@model.save(attribute, 
			wait: true
			success: @successfulUpdate
			error:  @handleError	
		)

	successfulUpdate: (model, response) ->
		$('#myModal').modal('hide')
		$("#myModal #content-box").val("")
		Backbone.pubSub.trigger('createArticle')

	handleError: (model, response) ->
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				alert "#{attribute} of article #{message}" for message in messages	
				@$("#content-box").focus()			

	render: ->
		$(@el).html(@template())
		@
