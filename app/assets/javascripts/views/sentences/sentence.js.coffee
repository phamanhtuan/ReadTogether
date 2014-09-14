class ReadTogether.Views.Sentence extends Backbone.View
  template: JST['sentences/sentence']
  tagName: 'span'
  className: 'sentence'

  events:
  	'click' : 'clickOnSentence'

  clickOnSentence: (event) =>
    $("#sentences .active").removeClass('active')
    $(@el).addClass('active')
    Backbone.pubSub.trigger('clickOnSentence', {sentence_id: @model.get('id'), article_id: @model.get('article_id')})
    

  render: ->
    $(@el).html(@template(sentence: @model))
    @
