# Reactive Favico
:warning: Work in progress :warning:

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
It's probably because your application is using the eithr the default favico provided by Meteor or one that is not on your domain. Set up your own favico so that JS can modify it.

I've provided an example favico in the example application `example/public/favicon.ico`. Put it in your application and add the following code to your main layout (in Jade):
```jade
head
  ...
  // Adding the ?v=2 bust the browser cache
  link(id='rxfavico', rel='icon', href='/favicon.ico?v=2')/
  ...
```
