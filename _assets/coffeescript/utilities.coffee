Element.implement 'animate', ->
  moo = moofx @;
  moo.animate.apply moo, arguments;
  @

Element.implement 'css', ->
  moo = moofx @;
  moo.style.apply moo, arguments;
  @

class @Utilities

  setupEvents: (elements, events) ->
    Object.each elements, (element, key) =>
      element.addEvents events[key] if element and events[key]

  log: ->
    args = if arguments.length <= 1 then arguments[0] else arguments
    console.log args if typeof console isnt 'undefined'

  isOdd: (index) ->
    index % 2 is 0

  pushState: (title, url) ->
    history.pushState {}, title, url
