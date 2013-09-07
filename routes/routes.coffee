exports.index = (req, res) ->
  res.render 'index', { title: 'Hello World' }

exports.about = (req, res) ->
  res.render 'about', { title: 'About Me' }