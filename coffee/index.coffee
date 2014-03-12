$($ ->
	$body = $('body')

	# Intensity should be a value between 0 and 1
	setBackgroundBlur = (intensity) ->
		$('.background-wrapper')
			.css('-webkit-filter', 'blur(' + Math.floor(intensity * 10) + 'px)')
			.css('-webkit-transform', 'scale(' + (1 + intensity * 0.5) + ')')

	if window.DeviceOrientationEvent
		# Devicemotion effects on the background if available
		window.addEventListener('deviceorientation', 
			(ev) ->
				setBackgroundBlur(ev.alpha / 360)
		)
	# Mouse effects on the background 
	# Problem if in any case devicemotion and mouse are available at the same time
	$body.mousemove(
		(e) -> 
			width = $body.width()
			height = $body.height()
			distance_width = Math.abs(e.pageX - width/2) / width
			distance_height = Math.abs(e.pageY - height/2) / height
			distance = Math.sqrt(Math.pow(distance_height, 2) +  Math.pow(distance_width, 2))
			setBackgroundBlur(distance)
	)
)