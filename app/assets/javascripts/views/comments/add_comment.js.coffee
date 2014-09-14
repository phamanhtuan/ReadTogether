class ReadTogether.Views.AddComment extends Backbone.View  
	template: JST['comments/add_comment']

	render: ->
		$(@el).html(@template())
		@
