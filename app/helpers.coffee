exports.helpers =
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