class Base extends Utilities

  constructor: ->

    @activePost = null
    @elements =
      timeline: document.id 'timeline'
      allMoments: document.getElements '.moment'

    # @events =
    #   timeline:
    #     'click:relay(a)': @showPost
    #   blog:
    #     'click:relay(a.hideBlog)': @hideBlog
    #   document:
    #     keydown: (event) =>
    #       @hideBlog() if event.key is 'esc'

    @setup()

  setup: ->
    # @setupEvents @elements, @events
    Array.each @elements.allMoments, @showMoments

  showMoment: (moment) ->
    @animate 'opacity', 1

  showMoments: (post, index) =>
    odd = @isOdd index

    klass = if odd then 'odd' else 'even'
    post.addClass klass

    # inject post
    # element.inject @elements.timeline

    moment = post.getElement '.momentBody'
    # moment = moment.pop()

    # reposition even moments
    moment.setStyle 'left', - (moment.getSize().x + 35) if not odd

    # show moments
    @showMoment.delay index * 200, moment

window.addEvents
  domready: ->
    window.base = new Base()
