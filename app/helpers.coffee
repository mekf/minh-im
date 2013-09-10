numeral = require 'numeral'
moment = require 'moment'

exports.helpers =
	formattedDate: (date) ->
		moment(date).format('MMMM, Do YYYY')