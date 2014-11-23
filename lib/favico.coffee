class @Favico
  @DEFAULT_OPTIONS:
    bgColor : '#d00'
    textColor : '#fff'
    fontFamily : 'sans-serif'
    fontStyle : 'bold'
    type : 'circle'
    position : 'down'
    animation : 'slide'
    elementId : false

  # Namespace for inner functions and static structures
  @type: {}
  @browser: {}
  @animation: {}

  constructor: (opt) ->
    @_queue = []
    @_readyCb = ->
    @_ready = @_stop = false

    # Merge initial options
    @_opt = _.extend @DEFAULT_OPTIONS, opt
    @_opt.bgColor = @hexToRgb @_opt.bgColor
    @_opt.textColor = @hexToRgb @_opt.textColor
    @_opt.position = @_opt.position.toLowerCase()
    isAnimExist = Favico.animation.types[String @_opt.animation]?
    @_opt.animation = if isAnimExist then @_opt.animation \
      else @DEFAULT_OPTIONS.animation
    isUp = (@_opt.position.indexOf 'up') > -1
    isLeft = (@_opt.position.indexOf 'left') > -1

    # Transform animation
    if isUp or isLeft
      for i in [0...animation.types['' + @_opt.animation].length]
        step = animation.types['' + @_opt.animation][i]
        if isUp
          if step.y < 0.6
            step.y = step.y - 0.4
          else
            step.y = step.y - 2 * step.y + (1 - step.w)
        if isLeft
          if step.x < 0.6
            step.x = step.x - 0.4
          else
            step.x = step.x - 2 * step.x + (1 - step.h)
        animation.types['' + @_opt.animation][i] = step;

    isTypeExist = Favico.type[String @_opt.type]
    @_opt.type = if isTypeExist then @_opt.type else @DEFAULT_OPTIONS.type
    try
      @_orig = link.getIcon()
      # Create temp canvas
      @_canvas = document.createElement 'canvas'
      # Create temp image
      @_img = document.createElement 'img'
      if @_orig.hasAttribute 'href'
        @_img.setAttribute 'src', @_orig.getAttribute 'href'
        # Get width/height
        @_img.onload = ->
          @_h = if @_img.height > 0 then @_img.height else 32
          @_w = if @_img.width > 0 then @_img.width else 32
          @_canvas.height = @_h
          @_canvas.width = @_w
          @_context = @_canvas.getContext '2d'
          icon.ready()
      else
        @_img.setAttribute 'src', ''
        @_h = 32
        @_w = 32
        @_img.height = @_h
        @_img.width = @_w
        @_canvas.height = @_h
        @_canvas.width = @_w
        @_context = @_canvas.getContext '2d'
        icon.ready()
    catch e
      throw Error "Initializing favico: #{e.message}"

  options: (opt) ->
    opt.n = if ( typeof opt.n) is 'number' then Math.abs(opt.n | 0) or opt.n
    opt.x = @_w * opt.x
    opt.y = @_h * opt.y
    opt.w = @_w * opt.w
    opt.h = @_h * opt.h
    opt.len = (String opt.n).length
    opt

  drawVideo: (video) ->
    return false if video.paused or video.ended or @_stop
    # nasty hack for FF webcam (Thanks to Julian Ćwirko, kontakt@redsunmedia.pl)
    try
      @_context.clearRect 0, 0, @_w, @_h
      @_context.drawImage video, 0, 0, @_w, @_h
    catch e
      console.log 'Favico nasty FF hack', e
    @_drawTimeout = setTimeout drawVideo, animation.duration, video
    link.setIcon @_canvas

  link = {}
  link.getIcon = ->
    elm = false
    url = ''
    # Get link element
    getLink = ->
      head = (document.getElementsByTagName 'head')[0]
      links = head.getElementsByTagName 'link'
      for link in links
        if ((/(^|\s)icon(\s|$)/i).test(link.getAttribute('rel')))
          return link
      false
    if @_opt.elementId
      # If img element identified by elementId
      elm = document.getElementById @_opt.elementId
      elm.setAttribute 'href', elm.getAttribute 'src'
    else
      # If link element
      elm = getLink()
      unless elm
        elm = document.createElement 'link'
        elm.setAttribute 'rel', 'icon'
        document.getElementsByTagName('head')[0].appendChild elm
    # Check if image and link url is on same domain. if not raise error
    url = if @_opt.elementId then elm.src else elm.href
    dataUrl = url.substr 0, 5
    if dataUrl isnt 'data:' and (url.indexOf document.location.hostname) is -1
      throw Error "Error setting favicon. Favicon image is on different domain\
        (Icon: #{url}, Domain: #{document.location.hostname})"
    elm.setAttribute 'type', 'image/png'
    elm
  link.setIcon = (canvas) ->
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
