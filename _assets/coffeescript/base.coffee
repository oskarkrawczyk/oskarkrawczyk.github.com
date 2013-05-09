class Base extends Utilities

  constructor: ->
    @sidebarOpen = false
    @activePost = null
    @elements =
      blog: document.id 'blog'
      timeline: document.id 'timeline'
      branchIt: document.id 'branch-it'
      showSidebar: document.id 'show-sidebar'
      allMoments: document.getElements '.moment'

    @events =
      branchIt:
        click: @branchIt
      showSidebar:
        click: @showSidebar
      # timeline:
      #   'click:relay(a)': @showPost
      # blog:
      #   'click:relay(a.hideBlog)': @hideBlog
      # document:
      #   keydown: (event) =>
      #     @hideBlog() if event.key is 'esc'

    @setup()

  setup: ->
    @setupEvents @elements, @events
    Array.each @elements.allMoments, @showMoments

  branchIt: (event) ->
    event.stop()

    window.__branchHost__ = 'http://branch.com'
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = 'https://secure.branch.com/assets/bookmarklet/bookmarklet.m.js'
    document.body.appendChild script

  showSidebar: (event) =>
    event.stop()

    if @siebarOpen
      width = 0
      shadow = '0 0 200px rgba(0, 0, 0, 0.55)'
      @siebarOpen = false
    else
      width = 300
      shadow = '0 0 5px rgba(0, 0, 0, 0.15)'
      @siebarOpen = true

    @elements.blog.animate
      'margin-left': width
      'box-shadow': shadow
    ,
      duration: if event.shift then 3000 else 800

  showMoment: (moment) ->
    @animate 'opacity', 1

  showMoments: (post, index) =>
    odd = post.hasClass 'odd'

    moment = post.getElement '.momentBody'

    # reposition even moments
    moment.setStyle 'left', - (moment.getSize().x + 35) if not odd

    # show moments
    @showMoment.delay index * 200, moment

window.addEvents
  domready: ->
    window.base = new Base()
