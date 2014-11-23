Favico::webcam = (action) ->
  if not window.URL or not window.URL.createObjectURL
    window.URL = window.URL || {}
    window.URL.createObjectURL = (obj) -> obj
  if Favico.browser.supported
    newVideo = false
    navigator.getUserMedia = navigator.getUserMedia or \
      navigator.oGetUserMedia or navigator.msGetUserMedia or \
      navigator.mozGetUserMedia or navigator.webkitGetUserMedia
    @_readyCb = ->
      try
        if action is 'stop'
          @_stop = true
          icon.reset()
          @_stop = false
          return
        newVideo = document.createElement 'video'
        newVideo.width = @_w
        newVideo.height = @_h
        navigator.getUserMedia
          video : true
          audio : false
        , (stream) ->
          newVideo.src = URL.createObjectURL stream
          newVideo.play()
          drawVideo newVideo
        , ->
      catch e
        throw Error "Setting webcam: #{e.message}"
    @_readyCb() if @_ready
