Package.describe({
  name: 'pierreeric:rxfavico',
  summary: 'Reactive favico for Meteor',
  version: '0.3.5_1',
  git: 'https://github.com/PEM--/rxfavico.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use(['coffeescript', 'underscore']);
  api.addFiles([
    // Main favico class
    'lib/favico.coffee',
    // Types of favico with text within
    'lib/types/badge.coffee',
    'lib/types/circle.coffee',
    'lib/types/rectangle.coffee',
    // Types of favico with web content
    'lib/types/image.coffee',
    'lib/types/video.coffee',
    'lib/types/webcam.coffee',
    // All animations
    'lib/animation.coffee',
    // Browser polyfills
    'lib/browser.coffee',
    // Color utils for the library
    'lib/utils.coffee',
    // Reactive use of the favicon
    'rxfavico.coffee'
  ], 'client');
});

Package.onTest(function(api) {
  api.use([
    'tinytest',
    'pierreeric:rxfavico'
  ]);
  api.addFiles('rxfavico-tests.js');
});
