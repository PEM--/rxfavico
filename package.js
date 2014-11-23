Package.describe({
  name: 'pierreeric:rxfavico',
  summary: 'Reactive favico for Meteor',
  version: '0.3.5_1',
  git: 'https://github.com/PEM--/rxfavico.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.use(['jquery', 'coffeescript', 'underscore']);
  api.addFiles([
    'favico.js',
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
