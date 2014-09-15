class ReadTogether.Views.SentencesIndex extends Backbone.View

  template: JST['sentences/index']

  initialize: (options)->
  	@collection.on('reset', @render, this)

  render: ->    
    @paragraph_id = 0
    $(@el).html(@template())
    @collection.sort()
    @collection.each(@renderSentence)
    @

  renderSentence: (sentence)=> 
    console.log(sentence.get('paragraph'))   
    view = new ReadTogether.Views.Sentence(model: sentence)
    if(@paragraph_id != sentence.get('paragraph'))
      @paragraph_id = sentence.get('paragraph')
      $("#sentences").append("<br/>")
    $("#sentences").append(view.render().el)
