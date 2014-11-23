### Original function (that don't work with Meteor)
Favico::link.getLink = ->
  head = (document.getElementsByTagName 'head')[0]
  links = head.getElementsByTagName 'link'
  for link in links
    if ((/(^|\s)icon(\s|$)/i).test(link.getAttribute('rel')))
      return link
  false
###
Favico::getLink = ->
  document.getElementById 'rxfavico'

Favico::getIcon = ->
  elm = false
  url = ''
  if @_opt.elementId
    # If img element identified by elementId
    elm = document.getElementById @_opt.elementId
    elm.setAttribute 'href', elm.getAttribute 'src'
  else
    # If link element
    elm = @getLink()
    unless elm
      elm = document.createElement 'link'
      elm.setAttribute 'rel', 'icon'
      document.getElementsByTagName('head')[0].appendChild elm
  # Check if image and link url is on same domain. if not raise error
  url = if @_opt.elementId then elm.src else elm.href
  #debugger
  dataUrl = url.substr 0, 5
  if dataUrl isnt 'data:' and (url.indexOf document.location.hostname) is -1
    throw Error "Setting favicon: Favicon image is on different domain\
      (Icon: #{url}, Domain: #{document.location.hostname})"
  elm.setAttribute 'type', 'image/png'
  elm

Favico::setIcon = (canvas) ->
  url = canvas.toDataURL 'image/png'
  if @_opt.elementId
    # if is attached to element (image)
    document.getElementById(@_opt.elementId).setAttribute 'src', url
  else
    # If is attached to fav icon
    if Favico.browser.ff or Favico.browser.opera
      # For FF we need to recreate element, atach to dom and remove old <link>
      old = @_orig
      @_orig = document.createElement 'link'
      @_orig.setAttribute 'rel', 'icon' if Favico.browser.opera
      @_orig.setAttribute 'rel', 'icon'
      @_orig.setAttribute 'type', 'image/png'
      document.getElementsByTagName('head')[0].appendChild @_orig
      @_orig.setAttribute 'href', url
      old.parentNode.removeChild old if old.parentNode
    else
      @_orig.setAttribute 'href', url
