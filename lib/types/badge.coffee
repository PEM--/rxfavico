Favico::badge = (number, opts) ->
  opts = (if typeof opts is 'string' then animation: opts else opts) or {}
  @_readyCb = ->
    #try
      if (if typeof number is 'number' then number > 0 else number isnt '')
        q = type: 'badge', options: n: number
        if 'animation' in opts and Favico.animation.types[String opts.animation]
          q.options.animation = String opts.animation
        if 'type' in opts && type['' + opts.type]
          q.options.type = '' + opts.type
        for o in ['bgColor', 'textColor']
          q.options[o] = @hexToRgb(opts[o]) if o in opts
        for o in ['fontStyle', 'fontFamily']
          q.options[o] = opts[o] if o in opts
        @_queue.push q
        throw Error 'Too many badges requests in queue.' if @_queue.length > 100
        @iconStart()
      else
        @iconReset()
    #catch e
    #  throw Error "Setting badge: #{e.message}"
  @_readyCb() if @_ready
