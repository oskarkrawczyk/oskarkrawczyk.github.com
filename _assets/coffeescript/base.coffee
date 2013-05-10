class Base extends Utilities

  constructor: ->
    @transformFrom = 'scale(0.95)'
    @sidebarOpen = false
    @elements =
      body: document.body
      sidebar: document.id 'sidebar'
      blog: document.id 'blog'
      posts: document.id 'posts'
      timeline: document.id 'timeline'
      branchIt: document.id 'branch-it'
      toggleSidebar: document.id 'toggle-sidebar'
      allMoments: document.getElements '.moment'

    @events =
      branchIt:
        click: @branchIt
      toggleSidebar:
        click: @toggleSidebar
      sidebar:
        'click:relay(a)': @showPost
      body:
        keydown: (event) =>
          @toggleSidebar event if event.key is 'esc'

    @setup()

  setup: ->
    @setupEvents @elements, @events
    Array.each @elements.allMoments, @showMoments

    # set default scale for the sidebar... don't want to do that in CSS
    if @elements.sidebar
      @elements.sidebar.css
        transform: @transformFrom

    @toggleSidebar() if document.location.hash.contains 'sidebar'

  branchIt: (event) ->
    event.stop()

    window.__branchHost__ = 'http://branch.com'
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = 'https://secure.branch.com/assets/bookmarklet/bookmarklet.m.js'
    document.body.appendChild script

  toggleSidebar: (event) =>
    event.stop() if event

    # longer duration when holding shift
    duration = if event and event.shift then 3000 else 800

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

  showPost: (event, element) =>
    event.stop()

    li = element.getParent 'li'
    siblings = li.getSiblings 'li'
    siblings.removeClass 'selected'
    li.addClass 'selected'

    href = element.get 'href'
    request = new Request
      url: href
      onRequest: @fadeOutPost
      onComplete: (response) =>
        @loadPost response, href

    request.get()

  loadPost: (response, href) =>
    elements = Elements.from response
    posts = elements.getElement '#posts'
    posts = posts.pop()
    posts.set 'id', ''

    showPost = =>
      @fadeInPost posts

    showPost.delay 500
    @pushState document.title, href # TODO: fetch the correct title

  fadeOutPost: =>
    @elements.posts.animate
      opacity: 0
      transform: 'scale(0.96)'
    ,
      duration: 500

  fadeInPost: (posts) =>
    @elements.posts.empty()
    @elements.posts.adopt posts
    @elements.posts.animate
      opacity: 1
      transform: 'scale(1)'
    ,
      duration: 500

window.addEvents
  domready: ->
    window.base = new Base()
