class ReadTogether.Views.SlideSentence extends Backbone.View
  className : "alert alert-danger slide-sentence-box"
  template: JST['sentences/slide']
  events:
    "click .edit-btn" : "editSentence"
    'blur .sentence-edit-box': 'blurEventHandle'
    'keydown .sentence-edit-box': 'clickEventHandle'
    'click .sentence-content span': 'clickWord'
  
  clickWord: (event) ->
    # console.log($(event.target).text())
    Backbone.pubSub.trigger('clickOnWord', {sentence_id: @model.get('id'), word: @$(event.target).text()})
  clickEventHandle: (event) ->    
    if event.keyCode == 13
      event.preventDefault()
      attributes = {'content': @$(".sentence-edit-box").val()}     
      @model.save(attributes,
      {
        wait: true
        success: @successfulUpdate
        error:  @handleError  
      })
      @pre_pre_key = event.keyCode
    else
      val = @$(".sentence-edit-box").val()
      if @model.get('paragraph') == 0
        return
      key = event.keyCode
      if(key == 190 || key == 191 || key == 49 )       
        if val.indexOf('.') > -1
          event.preventDefault()
        if val.indexOf('!') > -1
          event.preventDefault()
        if val.indexOf('?') > -1
          event.preventDefault()

  successfulUpdate: (model, response) =>
    Backbone.pubSub.trigger('editSentence', {sentence_id: @model.get('id'), article_id: @model.get('article_id')})

  editSentence: ->
    @$(".sentence-content").hide()
    @$(".sentence-edit-box").show()  
    @$(".sentence-edit-box").val(@model.get('content'))
    @$(".sentence-edit-box").focus()
  
  blurEventHandle: (event) ->
    @$(".sentence-edit-box").hide()  
    @$(".sentence-content").show()

  deleteSentence: (event) =>
    @model.destroy({wait: true, success: @successfulDelete, error:  @handleError})    
  
  successfulDelete: (model, response) =>
    Backbone.pubSub.trigger('deleteSentence', {sentence_id: @model.get('id'), article_id: @model.get('article_id')})
    @model.show = false
    @render()

  handleError: (model, response) ->   
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        console.log "#{attribute} of comment #{message}" for message in messages  
        @$(".comment-edit-box").focus()   
  initialize: ->
    Backbone.pubSub.on('clickOnSentence', @getSentenceOnEvent)
    @model.on("sync", @render, this)

  getSentenceOnEvent: (options) =>
    @initWaiting()
    @model.article_id =  options.article_id
    @model.set("id", options.sentence_id)
    @model.show = true
    @model.fetch()

  render: ->
    $(@el).html(@template(sentence: @model))
    if(@model.show)
      @$(".delete-btn").confirm({
        text: "Are you sure you want to delete that sentence?",
        title: "Confirmation required",
        confirm: @deleteSentence,     
        cancel: ->,      
        confirmButton: "Yes I am",
        cancelButton: "No",
        post: true
      })
      @$(".sentence-edit-box").hide()  
      $(@el).show()
    else
      $(@el).hide()
    @
  initWaiting: =>    
    $(@el).append(JST['waiting']())
    @$(".waiting-screen").css({"left": $(@el).position().left+"px"})
    @$(".waiting-screen").css({"top": $(@el).position().top+"px"})
    @$(".waiting-screen").css({"height": $(@el).outerHeight()+"px"})
    @$(".waiting-screen").css({"width": $(@el).outerWidth()+"px"})
    @$(".waiting-screen").show()
    
