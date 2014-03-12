$($ ->
	$body = $('body')

	# Intensity should be a value between 0 and 1
	setBackgroundBlur = (intensity) ->
		$('.background-wrapper')
			.css('-webkit-filter', 'blur(' + Math.floor(intensity * 10) + 'px)')
			.css('-webkit-transform', 'scale(' + (1 + intensity * 0.5) + ')')

	if window.DeviceMotionEvent
		# Devicemotion effects on the background
		window.addEventListener('devicemotion', 
			(ev) ->
				acc = ev.accelerationIncludingGravity
				setBackgroundBlur(acc.x / 10)
		)
	else 
		# Move effects on the background
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