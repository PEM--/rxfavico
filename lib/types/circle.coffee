Favico::type.circle = (opt) ->
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
  @_context.font = @_opt.fontStyle + ' ' +
    Math.floor(opt.h * (opt.n > 99 ? 0.85 : 1)) + 'px ' + @_opt.fontFamily;
  @_context.textAlign = 'center'
  if more
    @_context.moveTo opt.x + opt.w / 2, opt.y
    @_context.lineTo opt.x + opt.w - opt.h / 2, opt.y
    @_context.quadraticCurveTo(
      opt.x + opt.w,
      opt.y,
      opt.x + opt.w, opt.y + opt.h / 2)
    @_context.lineTo opt.x + opt.w, opt.y + opt.h - opt.h / 2
    @_context.quadraticCurveTo(opt.x + opt.w,
      opt.y + opt.h, opt.x + opt.w - opt.h / 2, opt.y + opt.h)
    @_context.lineTo opt.x + opt.h / 2, opt.y + opt.h
    @_context.quadraticCurveTo(opt.x,
      opt.y + opt.h, opt.x, opt.y + opt.h - opt.h / 2)
    @_context.lineTo opt.x, opt.y + opt.h / 2
    @_context.quadraticCurveTo opt.x, opt.y, opt.x + opt.h / 2, opt.y
  else
    @_context.arc(
      opt.x + opt.w / 2,
      opt.y + opt.h / 2,
      opt.h / 2, 0, 2 * Math.PI)
  @_context.fillStyle = "rgba(#{@_opt.bgColor.r},\
    #{@_opt.bgColor.g},#{@_opt.bgColor.b},#{opt.o})"
  @_context.fill()
  @_context.closePath()
  @_context.beginPath()
  @_context.stroke()
  @_context.fillStyle = "rgba(#{@_opt.textColor.r},\
    #{@_opt.textColor.g},#{@_opt.textColor.b},#{opt.o})"
  if typeof opt.n is 'number' and opt.n > 999
    @_context.fillText(
      "#{if opt.n > 9999 then 9 else Math.floor(opt.n / 1000)}k+",
      Math.floor(opt.x + opt.w / 2),
      Math.floor(opt.y + opt.h - opt.h * 0.2))
  else
    @_context.fillText(
      opt.n,
      Math.floor(opt.x + opt.w / 2),
      Math.floor(opt.y + opt.h - opt.h * 0.15)
    )
  @_context.closePath()
