Package.describe({
  name: 'pierreeric:rxfavico',
  summary: 'Reactive favicon for Meteor',
  version: '0.3.5_0',
  git: 'https://github.com/PEM--/rxfavico.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  api.addFiles('rxfavico.js');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('pierreeric:rxfavico');
  api.addFiles('rxfavico-tests.js');
});
