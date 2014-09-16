class ReadTogether.Views.ArticlesIndex extends Backbone.View

  template: JST['articles/index']
  events:
    'click .pagination .next' : 'nextPagination'
    'click .pagination .prev' : 'prevPagination'
    'click .pagination .pagination-btn' : 'goPagination'
    'click .tag-btn' : "goTagPage"
    
  initialize: ->
    Backbone.pubSub.on('createArticle', @createArticleEvent)
    @collection.on('reset', @render, this)
    @collection.on('change', @render, this)
    @collection.on('destroy', @render, this)

  goTagPage: (event) ->
    event.preventDefault()
    tag = $(event.target).text()
    @collection.page = 1
    window.ReadTogether.router.navigate("tag/"+encodeURIComponent(tag), {trigger: true})

  createArticleEvent: =>
    @collection.fetch({reset: true})

  destroyCommentEvent: =>
    @collection.fetch({reset: true})
    @render


  goPagination: (event) ->  
    event.preventDefault()
    @collection.goPage($(event.target).text())

  prevPagination: (event) ->
    event.preventDefault()
    @collection.previousPage()

  nextPagination: (event) ->
    event.preventDefault()
    @collection.nextPage()

  render: ->    
    $(@el).html(@template())
    @collection.each(@rednerSetences)
    @$("#pagination").html(JST['pagination']( pageInfo: @collection.pageInfo()))
    @

  rednerSetences: (article) =>  	
    @articleView = new ReadTogether.Views.Article(model: article)
    $(@el).append(@articleView.render().el)
  	