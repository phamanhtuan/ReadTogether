class ReadTogether.Collections.Sentences extends Backbone.Collection
	url: ->
		"/api/articles/"+@article_id+"/sentences"
	initialize: (options) ->
		@article_id = options.article_id
	comparator: (sentence1,sentence2)->
		if sentence1.get('paragraph')<sentence2.get('paragraph')
			false
		else
			if sentence1.get('paragraph')>sentence2.get('paragraph')
				true
			else
				if sentence1.get('position')<sentence2.get('position')
					false
				else 
					if sentence1.get('position')>sentence2.get('position')
						true
					else
					 	false

