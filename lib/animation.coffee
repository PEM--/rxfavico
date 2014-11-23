Favico.animation =
  duration: 40
  types:
    fade: [
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.0 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.1 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.2 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.3 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.4 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.5 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.6 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.7 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.8 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 0.9 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 1.0 }
    ]
    none: [
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 1 }
    ]
    pop: [
      { x: 1,   y: 1,   w: 0,   h: 0,   o: 1 }
      { x: 0.9, y: 0.9, w: 0.1, h: 0.1, o: 1 }
      { x: 0.8, y: 0.8, w: 0.2, h: 0.2, o: 1 }
      { x: 0.7, y: 0.7, w: 0.3, h: 0.3, o: 1 }
      { x: 0.6, y: 0.6, w: 0.4, h: 0.4, o: 1 }
      { x: 0.5, y: 0.5, w: 0.5, h: 0.5, o: 1 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 1 }
    ]
    popFade: [
      { x: 0.75, y: 0.75, w: 0,   h: 0,   o: 0 }
      { x: 0.65, y: 0.65, w: 0.1, h: 0.1, o: 0.2 }
      { x: 0.6,  y: 0.6,  w: 0.2, h: 0.2, o: 0.4 }
      { x: 0.55, y: 0.55, w: 0.3, h: 0.3, o: 0.6 }
      { x: 0.50, y: 0.50, w: 0.4, h: 0.4, o: 0.8 }
      { x: 0.45, y: 0.45, w: 0.5, h: 0.5, o: 0.9 }
      { x: 0.4,  y: 0.4,  w: 0.6, h: 0.6, o: 1 }
    ]
    slide: [
      { x: 0.4, y: 1,   w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.9, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.9, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.8, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.7, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.6, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.5, w: 0.6, h: 0.6, o: 1 }
      { x: 0.4, y: 0.4, w: 0.6, h: 0.6, o: 1 }
    ]

Favico::animationRun = (opt, cb, revert, step) ->
  type = if Favico.isPageHidden() then 'none' else @_opt.animation
  animationType = Favico.animation.types[type]
  if revert
    step = if step? then step else animationType.length - 1
  else
    step = if step? then step else 0
  cb = if cb then cb else ->
  return cb() unless step < animationType.length and step >= 0
  type[@_opt.type](_.extend(opt, animationType[step]))
  @_animTimeout = setTimeout ->
    if revert
      step = step - 1
    else
      step = step + 1
    Favico.animation.run opt, cb, revert, step
  , Favico.animation.duration
  link.setIcon @_canvas
