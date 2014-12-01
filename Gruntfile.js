module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    jsdoc : {
      dist : {
        src: ['./*.js', './*.md'],
        jsdoc: './node_modules/.bin/jsdoc',
        options: {
          destination: 'doc',
          configure: './node_modules/ink-docstrap/template/jsdoc.conf.json',
          template: './node_modules/ink-docstrap/template'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-jsdoc');

};
