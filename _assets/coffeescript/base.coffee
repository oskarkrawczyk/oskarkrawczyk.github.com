class Base extends Utilities

  constructor: ->
    @transformFrom = 'scale(0.95)'
    @sidebarOpen = false
    @elements =
      body: document.body
      sidebar: document.id 'sidebar'
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

    # set default scale for the sidebar... don't want to do that in CSS
    if @elements.sidebar
      @elements.sidebar.css
        transform: @transformFrom

  branchIt: (event) ->
    event.stop()

    window.__branchHost__ = 'http://branch.com'
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = 'https://secure.branch.com/assets/bookmarklet/bookmarklet.m.js'
    document.body.appendChild script

  showSidebar: (event) =>
    event.stop()

    # longer duration when holding shift
    duration = if event.shift then 3000 else 800

    # toggle values
    if @siebarOpen
      width = 0
      shadow = '0 0 50px rgba(0, 0, 0, 0.55)'
      background = '#aaaaaa'
      transform = @transformFrom
      @siebarOpen = false
    else
      width = 300
      shadow = '0 0 5px rgba(0, 0, 0, 0.15)'
      transform = 'scale(1)'
      background = '#f1f1f1'
      @siebarOpen = true

    # animate page
    @elements.blog.animate
      marginLeft: width
      boxShadow: shadow
    ,
      duration: duration

    # animate sidebar
    @elements.sidebar.animate
      transform: transform
    ,
      duration: duration

    # animate body
    @elements.body.animate
      backgroundColor: background
    ,
      duration: duration

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
