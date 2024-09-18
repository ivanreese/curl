require "sweetbread"

task "build", "Compile everything", ()->
  compile "global scripts", ()->
    write "public/script.js", coffee concat readAll "source/script/**/*.coffee"

  compile "html", "source/index.html", (path)->
    copy path, replace path, "source": "public"

task "watch", "Recompile on changes.", ()->
    watch "source", "build", reload

task "serve", "Spin up a live reloading server.", ()->
  serve "public"

task "start", "Build, watch, and serve.", ()->
  invoke "build"
  invoke "watch"
  invoke "serve"
