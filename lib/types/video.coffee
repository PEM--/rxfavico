Favico::video = (videoElement) ->
  @_readyCb = ->
    try
      if videoElement is 'stop'
        @_stop = true
        icon.reset()
        @_stop = false
        return
      videoElement.addEventListener 'play', ->
        drawVideo @
      , false
    catch e
      throw Error "Setting video: #{e.message}"
  @_readyCb() if @_ready
