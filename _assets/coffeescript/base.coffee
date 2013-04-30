class Base extends Utilities

  constructor: ->

    @activePost = null
    @elements =
      timeline: document.id 'timeline'
      branchIt: document.id 'branch-it'
      allMoments: document.getElements '.moment'

    @events =
      branchIt:
        click: @branchIt
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
