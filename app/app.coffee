###
Module dependencies.
###
express = require('express')
routes = require('./routes/routes')
# user = require('./routes/user')
http = require('http')
path = require('path')
app = express()

# all environments
app.configure ->
	app.set 'port', process.env.PORT or 3000
	app.set 'views', path.join(__dirname, '/views')
	app.set 'view engine', 'jade'
	app.use require('connect-assets')()
	app.use express.static(path.join(__dirname, '../', 'public')) # for images
	app.use express.favicon()
	app.use express.logger('dev')
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router

# development only
app.configure 'development', ->
	app.use express.errorHandler() 

# routes
app.get '/', routes.index
app.get '/about', routes.about

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"