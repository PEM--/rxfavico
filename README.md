# Reactive Favico
A reactive adaptation of [favico.js](http://lab.ejci.net/favico.js/) for Meteor.

![Favico with the default Meteor boilerplate](https://raw.githubusercontent.com/PEM--/rxfavico/master/asset/output.gif)

## Introduction
This package brings 2 pieces together:
* A reactive dictionnary `rxFavico` that facilitates the use of [favico.js](http://lab.ejci.net/favico.js/). Very handy for displaying notifications or tests results.
* The `Favico` class in the global space of your browser, just like a basic import of [favico.js](http://lab.ejci.net/favico.js/).

## Usage
### First, the markup
In your layout, just add a favico on which you set an id `rxfavico` and put your `favicon.ico` in your `/public` folder.

In Blaze:
```html
<head>
...
  <link id="rxfavico" rel="icon" href="/favicon.ico?v=2">
</head>
```

In Jade:
```jade
head
  ...
  link(id='rxfavico', rel='icon', href='/favicon.ico?v=2')/
```

### As a reactive dictionnary
The reactive dictionnary takes two values:
* `count`, a Number, set it to 0 to make the notification disappear.
* `type`, a String, which can take 2 values:
  * `info`, for a green display, the default value.
  * Any other value, for a red display.

Here is a simple example of usage in CoffeeScript:
```coffee
Template.hello.events
  'click button': ->
    counter = (rxFavico.get 'count') + 1
    type = if 5 < counter < 10 then 'error' else 'info'
    rxFavico.set 'type', type
    rxFavico.set 'count', counter
```

### Through the favico.js API
The [favico.js](http://lab.ejci.net/favico.js/) is bring in the browser as `Favico` just like a normal import:

Therefore using it is pretty easy and very described in their documentation. Here is a simple example in CoffeeScript:
```coffee
favico = new Favico
  bgColor: '#3d8a3a'
  position: 'up'
  animation: 'none'
favico.badge 1
```

## FAQ
### I don't see the favico that I've set
Simple, cache burst it just like meteor is doing for ensuring hot code reload.

Put an incremental index at the end of the `href` of your `link` tag, for
instance in Jade:
```jade
...
// Adding the ?v=2 bust the browser cache
link(id='rxfavico', rel='icon', href='/favicon.ico?v=2')/
...
```

### Cryptic error message with the default Meteor's favico
If you see this message:
```
Uncaught Error initializing favicon. Message: Error setting favicon. Favicon image is on different domain (Icon: , Domain: localhost)
```
It's probably because your application is using the either the default favico provided by Meteor or one that is not on your domain. Set up your own favico so that JS can modify it.

I've provided an example favico in the example application `example/public/favicon.ico`. Put it in your application and add the following code to your main layout (in Jade):
```jade
head
  ...
  // Adding the ?v=2 bust the browser cache
  link(id='rxfavico', rel='icon', href='/favicon.ico?v=2')/
  ...
```
