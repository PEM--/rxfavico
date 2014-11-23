Template.hello.events
  'click button': ->
    counter = (rxFavico.get 'count') + 1
    type = if 5 < counter < 10 then 'error' else 'info'
    rxFavico.set 'type', type
    rxFavico.set 'count', counter
