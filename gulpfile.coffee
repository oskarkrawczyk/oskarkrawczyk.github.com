gulp         = require "gulp"
gutil        = require "gulp-util"
coffee       = require "gulp-coffee"
coffeelint   = require "gulp-coffeelint"
concat       = require "gulp-concat"
uglify       = require "gulp-uglify"
gulpif       = require "gulp-if"
changed      = require "gulp-changed"
cssnano      = require "gulp-cssnano"
sass         = require "gulp-sass"
autoprefixer = require('gulp-autoprefixer');

# other
# stylelint   = require "stylelint"
browserSync = require "browser-sync"
bsInjector  = require "bs-snippet-injector"

options =
  browsersync:
    server:
      baseDir: "./"
    open: false
    xip: false
    port: 2001
    socket:
      port: 2003
    ui:
      port: 2002
  coffee:
    bare: false

handleError = (err) ->
  console.log(err.toString())
  this.emit "end"

gulp.task "coffee", ->

  commonTasks = (gulp, source, dest) ->
    gulp.src source
    .pipe(changed dest)
    .pipe(gulpif(/[.]coffee$/, coffeelint("coffeelint.json")))
    .pipe(gulpif(/[.]coffee$/, coffeelint.reporter()))
    .pipe(gulpif(/[.]coffee$/, coffee()))
    .on("error", handleError)
    .pipe(concat "base.js")
    .on("error", handleError)
    .pipe(uglify())
    .on("error", handleError)
    .pipe(gulp.dest dest)
    .pipe(browserSync.reload
      stream: true
    )

  commonTasks gulp, [
    "public/source/base.coffee"
  ], "public/dist/"

gulp.task "css", ->

  commonTasks = (gulp, source, dest) ->
    gulp.src source
    .pipe(changed dest)
    .pipe(concat "base.css")
    .pipe(sass())
    .on("error", handleError)
    .pipe(autoprefixer())
    .on("error", handleError)
    .pipe(cssnano())
    .on("error", handleError)
    .pipe(gulp.dest dest)
    .pipe(browserSync.reload
      stream: true
    )

  commonTasks gulp, [
    "public/source/base.scss"
  ], "public/dist/"

gulp.task "html", ->
  gulp.src "*.html"
  .pipe(browserSync.reload
    stream: true
  )

gulp.task "fonts", ->
  dest = "public/dist/fonts/"
  gulp.src "public/source/fonts/*.*"
  .pipe(changed dest)
  .pipe(gulp.dest dest)
  .pipe(browserSync.reload
    stream: true
  )


# watch files and fire fire appropriate tasks when needed
gulp.task "watch", ["coffee", "css", "html", "fonts"], ->
  browserSync.init options.browsersync

  # landing and app
  gulp.watch "public/source/*.coffee",  ["coffee"]
  gulp.watch "public/source/*.scss",    ["css"]
  gulp.watch "**/*.html",               ["html"]
  gulp.watch "public/source/fonts/*.*", ["fonts"]
