###
Module dependencies.
###
express = require('express')
routes = require('./routes')
helpers = require('./helpers')
http = require('http')
path = require('path')

# init the express app
app = express()

# include poet + pass app to it
poet = require('poet')(app,
  posts: path.join(__dirname, '_posts')
  metaFormat: 'json'
)

# all environments
app.configure ->
	poet.init().then ->
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
	app.locals
		monthNames: (index) -> 
			switch index.toString()
				when '0' then 'January'
				when '1' then 'February'
				when '2' then 'March'
				when '3' then 'April'
				when '4' then 'May'
				when '5' then 'June'
				when '6' then 'July'
				when '7' then 'August'
				when '8' then 'September'
				when '9' then 'October'
				when '10' then 'November'
				else 'December'

# development only
app.configure 'development', ->
	app.use express.errorHandler() 

# routes
app.get '/', routes.index
app.get '/about', routes.about
app.get '/archives', routes.archives

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')}"