# Reactive Favico
:warning: Work in progress :warning:

## FAQ
### Cryptic error message with the default Meteor's favicon
If you see this message:
```
Uncaught Error initializing favicon. Message: Error setting favicon. Favicon image is on different domain (Icon: , Domain: localhost)
```
It's probably because your application is using the default favico provided by Meteor. Set up your own favico so that JS can modify it.

I've provided an example favico in the example application `example/public/favicon.ico`. Put it in your application and add the following code to your main layout (in Jade):
```jade
head
  ...
  // Adding the ?v=2 bust the browser cache
  link(rel='icon', href='/favicon.ico?v=2')/
  ...
```
