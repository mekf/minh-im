numeral = require 'numeral'
moment = require 'moment'

exports.helpers =
	formattedDate: (date) ->
		moment(date).format('MMMM, Do YYYY')
	shortDate: (date) ->
		moment(date).format('DD/MM/YYYY')