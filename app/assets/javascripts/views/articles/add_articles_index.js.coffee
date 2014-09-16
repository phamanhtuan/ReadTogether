class ReadTogether.Views.AddingArticle extends Backbone.View  
	template: JST['articles/add_article']
	tags: []
	events:
		'click #save-btn': 'createArticle'
		'click #myModal .tags-list a' : 'deleteTag'
		'keydown input[name=tag-input-box]' : 'addTag'	

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

	deleteTag: (event) ->
		val = $(event.target).text()
		if( val != "undefined" && val != "")
			@tags = _.without(@tags, val);
		$(event.target).tooltip('destroy')
		$(event.target).remove()

	createArticle: (event)->		
		event.preventDefault()		
		attribute = {content: @$('#content-box').val(), tags: @tags.join("||")}
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
