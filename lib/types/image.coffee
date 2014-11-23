Favico::type.image = (imageElement) ->
  @_readyCb = ->
    try
      w = imageElement.width
      h = imageElement.height
      newImg = document.createElement 'img'
      ratio = if (w / @_w < h / @_h) then (w / @_w) else (h / @_h)
      newImg.setAttribute 'src', imageElement.getAttribute 'src'
      newImg.height = (h / ratio)
      newImg.width = (w / ratio)
      @_context.clearRect 0, 0, @_w, @_h
      @_context.drawImage newImg, 0, 0, @_w, @_h
      link.setIcon @_canvas
    catch e
      throw Error "Setting image: #{ e.message}"
  @_readyCb() if @_ready
