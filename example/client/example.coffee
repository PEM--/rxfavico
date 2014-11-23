counter = 1

Template.hello.events
  'click button': ->
    switch
      when 5 < counter < 10 then  rxFavico.set 'type', 'error'
      when counter is 10 then rxFavico.set 'type', 'info'
    rxFavico.set 'count', counter++
