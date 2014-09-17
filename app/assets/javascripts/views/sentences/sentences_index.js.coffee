class ReadTogether.Views.SentencesIndex extends Backbone.View

  template: JST['sentences/index']

  initialize: (options)->
    @collection.on('reset', @render, this)
    Backbone.pubSub.on('deleteSentence', @deleteSentenceOnEvent, this)
    Backbone.pubSub.on('editSentence', @editSentenceOnEvent, this)
    @active_sentence = -1

  editSentenceOnEvent: (options) ->
    @initWaiting();
    @collection.fetch({reset: true})
    @active_sentence = options.sentence_id
  deleteSentenceOnEvent : ->
    @initWaiting()
    @collection.fetch({reset: true})
    @active_sentence = -1
  render: ->    
    $(@el).html(@template())
    @collection.sort()
    @collection.each(@renderSentence)
    @

  renderSentence: (sentence)=>  
    if @active_sentence == sentence.get("id")
      sentence.active = true
    else 
      sentence.active = false
    view = new ReadTogether.Views.Sentence(model: sentence)
    if(@paragraph_id != sentence.get('paragraph'))
      @paragraph_id = sentence.get('paragraph')
      $("#sentences").append("<br/>")
    $("#sentences").append(view.render().el)

  initWaiting: =>
    $(@el).append(JST["waiting"]())
    @$(".waiting-overlay").hide()
    @$(".waiting-overlay").css({"left": $(@el).position().left+"px"})
    @$(".waiting-overlay").css({"top": $(@el).position().top+"px"})
    @$(".waiting-overlay").css({"height": $(@el).outerHeight()+"px"})
    @$(".waiting-overlay").css({"width": $(@el).outerWidth()+"px"})
