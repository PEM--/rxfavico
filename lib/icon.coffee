Favico::iconReady = ->
  @_ready = true
  @iconReset()
  @_readyCb()

Favico::iconReset = ->
  return unless @_ready
  @_queue = []
  @_lastBadge = false
  @_context.clearRect 0, 0, @_w, @_h
  @_context.drawImage @_img, 0, 0, @_w, @_h
  window.clearTimeout @_animTimeout
  window.clearTimeout @_drawTimeout

Favico::iconStart = ->
  console.log @
  return if @_running or not @_ready
  finished = ->
    @_lastBadge = @_queue[0]
    @_running = false
    if @_queue.length > 0
      @_queue.shift()
      icon.start()
  if @_queue.length > 0
    @_running = true
    run = ->
      # Apply options for this animation
      for a in [
        'type', 'animation'
        'bgColor', 'textColor'
        'fontFamily', 'fontStyle'
      ]
        @_opt[a] = @_queue[0].options[a] if a in @_queue[0].options
      Favicon.animation.run @_queue[0].options, (-> finished()), false
    if @_lastBadge
      Favicon.animation.run @_lastBadge.options, (-> run()), true
    else
      run()
