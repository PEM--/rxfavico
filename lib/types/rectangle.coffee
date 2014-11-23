Favico.type.rectangle = (opt) ->
  opt = options opt
  more = false
  if opt.len is 2
    opt.x = opt.x - opt.w * 0.4
    opt.w = opt.w * 1.4
    more = true
  else if opt.len >= 3
    opt.x = opt.x - opt.w * 0.65
    opt.w = opt.w * 1.65
    more = true
  @_context.clearRect 0, 0, @_w, @_h
  @_context.drawImage @_img, 0, 0, @_w, @_h
  @_context.beginPath()
  @_context.font = "#{@_opt.fontStyle} \
    #{Math.floor(opt.h * (if opt.n > 99 then 0.9 else 1))}px \
    #{@_opt.fontFamily}"
  @_context.textAlign = 'center'
  @_context.fillStyle = "rgba(#{@_opt.bgColor.r},\
    #{@_opt.bgColor.g},#{@_opt.bgColor.b},#{opt.o})"
  @_context.fillRect opt.x, opt.y, opt.w, opt.h
  @_context.fillStyle = "rgba(#{@_opt.textColor.r},\
    #{@_opt.textColor.g},#{@_opt.textColor.b},#{opt.o})"
  if (typeof opt.n) is 'number' and opt.n > 999
    @_context.fillText(
      "#{if opt.n > 9999 then 9 else Math.floor(opt.n / 1000)}k+",
      Math.floor(opt.x + opt.w / 2),
      Math.floor(opt.y + opt.h - opt.h * 0.2)
    )
  else
    @_context.fillText(
      opt.n,
      Math.floor(opt.x + opt.w / 2),
      Math.floor(opt.y + opt.h - opt.h * 0.15)
    )
  @_context.closePath()
