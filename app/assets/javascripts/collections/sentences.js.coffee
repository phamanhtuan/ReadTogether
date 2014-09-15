class ReadTogether.Collections.Sentences extends Backbone.Collection
	url: ->
		"/api/articles/"+@article_id+"/sentences"
	initialize: (options) ->
		@article_id = options.article_id

	comparator: (item) ->
		return parseInt(item.get("position")) + 1000*parseInt(item.get("paragraph"))
	# comparator: (sentence1,sentence2)->
	# 	console.log(sentence1.get('paragraph'))
	# 	console.log(sentence2.get('paragraph'))
	# 	console.log(parseInt(sentence1.get('paragraph'))<parseInt(sentence2.get('paragraph')))
	# 	if parseInt(sentence1.get('paragraph'))<parseInt(sentence2.get('paragraph'))
	# 		false
	# 	else
	# 		true
	# 		# if parseInt(sentence1.get('paragraph'))>parseInt(sentence2.get('paragraph'))
	# 		# 	true
	# 		# else
	# 		# 	if parseInt(sentence1.get('position'))<parseInt(sentence2.get('position'))
	# 		# 		false
	# 		# 	else 
	# 		# 		if parseInt(sentence1.get('position'))>parseInt(sentence2.get('position'))
	# 		# 			true
	# 		# 		else
	# 		# 		 	false

