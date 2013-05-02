// Karma configuration
// Generated on Thu May 02 2013 00:40:07 GMT+0200 (CEST)


// base path, that will be used to resolve files and exclude
basePath = '..';


// list of files / patterns to load in the browser
files = [
  JASMINE,
  JASMINE_ADAPTER,

  {
    pattern: 'spec/javascripts/fixtures/*.html',
    watched: true,
    included: false,
    served: true
  },
  'http://code.jquery.com/jquery-1.9.1.min.js',
  'spec/javascripts/helpers/jasmine-jquery.js',
  'spec/javascripts/helpers/fixtures.js',

  // code to test
  'app/assets/javascripts/rubber_ring/persistence_manager.coffee',
  'app/assets/javascripts/rubber_ring/duplicable_editor.coffee',
  // specs
  'spec/javascripts/*_spec.*'
];


// list of files to exclude
exclude = [

];


// test results reporter to use
// possible values: 'dots', 'progress', 'junit'
reporters = ['progress'];


// web server port
port = 9876;


// cli runner port
runnerPort = 9100;


// enable / disable colors in the output (reporters and logs)
colors = true;


// level of logging
// possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
logLevel = LOG_INFO;


// enable / disable watching file and executing tests whenever any file changes
autoWatch = true;


// Start these browsers, currently available:
// - Chrome
// - ChromeCanary
// - Firefox
// - Opera
// - Safari (only Mac)
// - PhantomJS
// - IE (only Windows)
browsers = ['PhantomJS'];


// If browser does not capture in given timeout [ms], kill it
captureTimeout = 60000;


// Continuous Integration mode
// if true, it capture browsers, run tests and exit
singleRun = false;

preprocessors = {
	'**/*.coffee': 'coffee'
};
