class ReadTogether.Views.CommentsIndex extends Backbone.View  
	template: JST['comments/index']
	className: 'panel panel-info'

	events:
		'keydown textarea[name=new-comment]' : 'submitAddingComment'
		'click .pagination .next' : 'nextPagination'
		'click .pagination .prev' : 'prevPagination'
		'click .pagination .pagination-btn' : 'goPagination'

	initialize: ->
		Backbone.pubSub.on('clickOnSentence', @getCommentOnEvent)
		@collection.on('reset', @render, this)
		@collection.on('add', @destroyCommentEvent, this)
		@collection.on('destroy', @destroyCommentEvent, this)
		@collection.on('change', @destroyCommentEvent, this)
		
	destroyCommentEvent: =>
		@collection.fetch({reset: true})
		@render


	goPagination: (event) ->	
		event.preventDefault()
		@collection.goPage($(event.target).text())

	prevPagination: (event) ->
		event.preventDefault()
		@collection.previousPage()

	nextPagination: (event) ->
		event.preventDefault()
		@collection.nextPage()

	getCommentOnEvent: (options)=>
		@initWaiting()
		@collection.sentence_id = options.sentence_id	
		@collection.article_id = options.article_id			
		@collection.show = true
		@collection.fetch({reset:true})
		

	submitAddingComment: (event) ->		
		if event.keyCode == 13
			event.preventDefault()
			attributes = {content:@$('textarea[name=new-comment]').val(), sentence_id: @collection.sentence_id}			
			@collection.create attributes, 
				wait: true
				success: -> $('textarea[name=new-comment]').val('')					
				error: @handleError

	handleError: (comment, response) ->		
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				console.log "#{attribute} of comment #{message}" for message in messages

	addComment: (comment) ->
		newComment = new ReadTogether.Views.Comment(model: comment)
		$("#comments-template ").append(newComment.render().el)

	render: ->		
		$(@el).html(@template({comments: @collection}))
		if @collection.show
			addCommentTemplate = new ReadTogether.Views.AddComment()
			@$("#add-comment").html(addCommentTemplate.render().el)
			@collection.each(@renderComment)
			@$('textarea[name=new-comment]').focus()
			@$('.comment-btn span').tooltip({ 'trigger': 'hover', 'placement': 'top'})
			@$("#pagination").append(JST['pagination']( pageInfo: @collection.pageInfo()))		
		@

	renderComment: (comment) ->		
		commentsTemplate = new ReadTogether.Views.Comment(model: comment)
		$("#comments-template").append(commentsTemplate.render().el)
	initWaiting: =>	
		$(@el).append(JST['waiting']())
		@$(".waiting-screen").css({"left": $(@el).position().left+"px"})
		@$(".waiting-screen").css({"top": $(@el).position().top+"px"})
		@$(".waiting-screen").css({"height": $(@el).outerHeight()+"px"})
		@$(".waiting-screen").css({"width": $(@el).outerWidth()+"px"})
		@$(".waiting-screen").show()
