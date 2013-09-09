exports.index = (req, res) ->
  res.render 'index', { title: "Hello! I'm Minh" }

exports.about = (req, res) ->
  res.render 'about', { title: 'About Me' }

 exports.archives = (req, res) ->
  res.render 'archives', { title: 'Archive' }