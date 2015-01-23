var gulp = require('gulp');
var jsdoc = require("gulp-jsdoc");
var date = new Date;

gulp.task('jsdoc', function() {
  gulp.src(["./OmniFocusLibrary.js", './README.md'])
  .pipe(jsdoc.parser({plugins: ['plugins/markdown']}))
  .pipe(jsdoc.generator('./doc', {
    path: 'ink-docstrap',
    systemName      : 'OmniFocusLibrary.js',
    footer          : "Please enjoy!",
    copyright       : "Copyright Brandon Pittman — 2014-" + date.getFullYear(),
    navType         : "vertical",
    theme           : "spacelab",
    linenums        : true,
    collapseSymbols : false,
    inverseNav      : true,
    cleverLinks           : true,
    monospaceLinks        : true,
    dateFormat            : "ddd MMM Do YYYY",
    outputSourceFiles     : true,
    outputSourcePath      : true,
    allowUnknownTags      : true,
    highlightTutorialCode : true,
    protocol              : "fred://",
    tags                  : {
      allowUnknownTags : true
    }
  }));
});
