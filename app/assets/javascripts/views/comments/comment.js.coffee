class ReadTogether.Views.Comment extends Backbone.View  
	template: JST['comments/comment']
	tagName: 'a'
	className: 'list-group-item list-group-item-warning comment-box'
	attributes: {'data-title': "Click to edit", 'data-placement': 'right', 'rel':"tooltip"}

	events:
		'click .edit-btn': 'editComment'
		'blur .comment-edit-box': 'blurEventHandle'
		'keydown .comment-edit-box': 'clickEventHandle'

	clickEventHandle: (event) =>			
		if event.keyCode == 13
			event.preventDefault()
			attributes = {'content': @$(".comment-edit-box").val()}		
			@initWaiting()	
			@model.save(attributes,
			{
				wait: true
				success: @successfulUpdate
				error:  @handleError	
			})		

	successfulUpdate: (model, event)->
		console.log('success')
	
	handleError: (model, response) ->		
		if response.status == 422
			errors = $.parseJSON(response.responseText).errors
			for attribute, messages of errors
				console.log "#{attribute} of comment #{message}" for message in messages	
				@$(".comment-edit-box").focus()			

	blurEventHandle: (event) ->
		@$(".comment-edit-box").hide()	
		@$(".comment-content").show()
		

	editComment: ->
		@$(".comment-content").hide()
		@$(".comment-edit-box").show()	
		@$(".comment-edit-box").val(@model.get('content'))
		@$(".comment-edit-box").focus()

	deleteComent: (event) =>				
		@model.destroy()
	render: ->		
		$(@el).html(@template(comment: @model))
		@$(".comment-edit-box").hide()
		@$(".delete-btn").confirm({
		    text: "Are you sure you want to delete that comment?",
		    title: "Confirmation required",
		    confirm: @deleteComent,   	
		    cancel: ->, 		 
		    confirmButton: "Yes I am",
		    cancelButton: "No",
		    post: true
		})
		@

	initWaiting: =>	
		$(@el).append(JST['waiting']())
		@$(".waiting-screen").css({"left": $(@el).position().left+"px"})
		@$(".waiting-screen").css({"top": $(@el).position().top+"px"})
		@$(".waiting-screen").css({"height": $(@el).outerHeight()+"px"})
		@$(".waiting-screen").css({"width": $(@el).outerWidth()+"px"})
		@$(".waiting-screen").show()
