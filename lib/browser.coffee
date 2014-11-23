Favico.browser =
  # Signature of browser
  ff: typeof InstallTrigger != 'undefined'
  chrome: !!window.chrome
  opera: !!window.opera || navigator.userAgent.indexOf('Opera') >= 0
  ie: false
  safari: ((Object::toString.call window.HTMLElement).indexOf 'Constructor') > 0

Favico.browser.supported = Favico.browser.chrome or \
  Favico.browser.ff or Favico.browser.opera

Favico.isPageHidden = ->
  document.hidden or document.msHidden or document.webkitHidden \
    or document.mozHidden
