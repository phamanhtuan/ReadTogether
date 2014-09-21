class ReadTogether.Collections.Vocabularies extends Backbone.Collection
	sentence_id: -1
	id: -1
	url: "/api/vocabularies"

	sync: (method, model, options) ->
	   	options || (options = {})
	   	if(method =='read')
	   		options.url = "/api/vocabularies?sentence_id="+@sentence_id
	   	if(method =='create')
	   		options.url = "/api/vocabularies"
	   	if @sentence_id != -1	
	   		Backbone.sync.apply(this, [method, model, options])