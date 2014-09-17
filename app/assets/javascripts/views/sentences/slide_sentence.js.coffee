class ReadTogether.Views.SlideSentence extends Backbone.View
  className : "alert alert-danger slide-sentence-box"
  template: JST['sentences/slide']
  events:
    "click .edit-btn" : "editSentence"
    'blur .sentence-edit-box': 'blurEventHandle'
    'keydown .sentence-edit-box': 'clickEventHandle'

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
    Backbone.pubSub.on('clickOnSentence', @getSentenceOnEvent, this)
    @model.on("change", @render, this)

  getSentenceOnEvent: (options) =>
    @model.article_id =  options.article_id
    @model.set("id", options.sentence_id)
    @model.show = true
    @model.fetch()

  render: =>
    if(@model.show)
      $(@el).html(@template(sentence: @model))
      $(@el).show()
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
    else
      $(@el).hide()
    @
