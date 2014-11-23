favico = null
$ ->
  favico = new Favico
    bgColor: '#3d8a3a'
    position: 'up'
    animation: 'none'

rxFavico = new ReactiveDict
rxFavico.set 'count', 0
rxFavico.set 'type', 'info'

Tracker.autorun ->
  count = rxFavico.get 'count'
  type = rxFavico.get 'type'
  favico?.badge count, bgColor: if type is 'info' then '#3d8a3a' else '#ac1b1b'

window.rxFavico = rxFavico
