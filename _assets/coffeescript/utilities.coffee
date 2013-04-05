Element.NativeEvents.popstate = 2;

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

  pushUrl: (url) =>
    o =
      url: url
    history.pushState o, null, "#!#{url}"
    # history.go 0
    # document.location = "#!#{url}"

  clearUrl: =>
    history.pushState null, null, '/'
    # history.go 0
    # document.location = '/'

  getFilename: (path) =>
    path = path.split '/'
    path.getLast()

  dehashbang: (url) =>
    url.replace '#!', ''

  template:

    get: (templateFor) ->
      template = document.getElement "script[data-template-for=#{templateFor}]"
      template.get 'text' if template

    parse: (template, subs) ->
      Elements.from template.substitute subs

