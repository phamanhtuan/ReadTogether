class ReadTogether.Models.SlideSentence extends Backbone.Model
	article_id: -1
	id: -1
	url: -> 
		"/api/articles/" + @article_id + "/sentences/" + @id