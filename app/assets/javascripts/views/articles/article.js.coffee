class ReadTogether.Views.Article extends Backbone.View  
	template: JST['articles/article']	
	tags: []
	className: 'panel panel-success'
	events: 
		'click .function-btn.edit-btn': 'editArticle'
		'click #save-btn': 'editArticleSubmit'
		'keydown input[name=tag-input-box]' : 'addTag'	
		'click #editArticleModal .tags-list a' : 'deleteTag'
	initialize: ->
		@model.on("reset", @render, this)

	deleteTag: (event) ->
		val = $(event.target).text()
		if( val != "undefined" && val != "")
			@tags = _.without(@tags, val);
		$(event.target).tooltip('destroy')
		$(event.target).remove()
	addTag: (event) =>
		if event.keyCode == 13
			event.preventDefault()
			if( @tags == 'undefined')
				@tags = []
			val = 	@$("input[name=tag-input-box]").val()
			if($.inArray(val, @tags) == -1)
				val = $.trim(@$("input[name=tag-input-box]").val())
				if(val != "" && val != "undefined")
					@tags.push(@$("input[name=tag-input-box]").val())
					attributes_a= {'data-title': 'delete', text: val, class: 'function-btn'}
					attributes_span= { class: 'label-size'}
					$('<span/>', attributes_span).html($('<a/>',attributes_a )).appendTo(@$(".tags-list"))
			@$('a.function-btn').tooltip({ 'trigger': 'hover', 'placement': 'top'})
			@$("input[name=tag-input-box]").val("")			

	editArticleSubmit: (event)->					
		attribute = {content: @$('#content-box').val(), tags: @tags.join("||")}
		@model.save(attribute, 
			wait: true
			success: @successfulUpdate
			error:  @handleError	
		)

	successfulUpdate: (model, response) =>
		@$("#editArticleModal").modal('hide')
		$('body').removeClass('modal-open')
		$('.modal-backdrop').remove()
		@model.fetch(reset: true)
	
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
		for sentence in @model.get('sentences')
			if (typeof body[sentence['paragraph']] == 'undefined')
				body[sentence['paragraph']] = []				
			body[sentence['paragraph']].push(sentence['content'])
		for paragraph in body
			body_final.push(paragraph.join(" "))
		@tags = []
		for tag in @model.get('tags')
			@tags.push(tag['title'])
			attributes_a= { 'data-title': 'delete', text: tag['title'], class: 'function-btn'}
			attributes_span= {  class: 'label-size'}
			@$(".tags-list").append($('<span/>',attributes_span ).html($('<a/>',attributes_a )))
		@$("#content-box").val(body_final.join("\n"))
		@$('a.function-btn').tooltip({ 'trigger': 'hover', 'placement': 'top'})		
		@$("#editArticleModal").modal('show')

		
	render: ->				
		$(@el).html(@template(model: @model))	
		for tag in @model.get('tags')				
			attributes_a= { text: tag['title']}
			attributes_span= { class: 'label-size'}
			@$(".tags-box").append($('<span/>',attributes_span ).html($('<a/>',attributes_a )))
		# @sentencesCollection = new ReadTogether.Collections.ArticleSentences({article_id: @model.get('id')})
		# @sentencesCollection.fetch({reset: true})
		# @sentencesView = new ReadTogether.Views.ArticleSentences(collection: @sentencesCollection)
		# $(@el).append(@sentencesView.render().el)	
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
		@model.destroy()
