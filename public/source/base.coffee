top       = 0
left      = 0
docHeight = 0
opened    = false

# nothing but webkit supports shapes in CSS clip-path
noClipPath = ->
  navigator.userAgent.indexOf("AppleWebKit") is -1

repositionStart = (mail, mailSpander) ->
  coords    = mail.getBoundingClientRect()
  docHeight = document.body.scrollHeight

  top  = coords.top + (coords.height / 2)
  left = coords.left + (coords.width / 2)

  defaultPath = "circle(0px at #{left}px #{top}px)"

  mailSpander.style["-webkit-clip-path"] = defaultPath
  mailSpander.style.height = "#{docHeight}px"

  if noClipPath()
    mailSpander.classList.add "hidden"

window.addEventListener "DOMContentLoaded", ->

  mail        = document.querySelector ".mail"
  mailSpander = document.querySelector ".mailSpander"

  if noClipPath()
    mailSpander.classList.add "fallback"

  repositionStart mail, mailSpander

  mail.addEventListener "click", (event) ->
    event.stopPropagation()
    event.preventDefault()

    if opened
      opened = false
      mail.classList.remove "active"
      repositionStart mail, mailSpander

    else
      opened = true
      mail.classList.add "active"
      mailSpander.style["-webkit-clip-path"] = "circle(#{docHeight * 2}px at #{left}px #{top}px)"

      if noClipPath()
        mailSpander.classList.remove "hidden"

  window.addEventListener "resize", ->
    repositionStart mail, mailSpander

  feed = new Instafeed
    get:         "user"
    userId:      "427572618"
    accessToken: "427572618.33afb76.1c728966039a493dbeb18c73401daba3"
    limit:       4

  feed.run()
