$($ ->
	$body = $('body')
	$body.mousemove(
		(e) -> 
			width = $body.width()
			height = $body.height()
			distance_width = Math.abs(e.pageX - width/2) / width
			distance_height = Math.abs(e.pageY - height/2) / height
			distance = Math.sqrt(Math.pow(distance_height, 2) +  Math.pow(distance_width, 2))
			$('.background-wrapper')
				.css('-webkit-filter', 'blur(' + Math.floor(distance * 10) + 'px)')
				.css('-webkit-transform', 'scale(' + (1 + distance * 0.5) + ')')
	)
)