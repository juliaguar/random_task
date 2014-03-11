$(function() {
	$('body').mousemove(function(e) {
		var width = $('body').width();
		var height = $('body').height();
		var distance_width = Math.abs(e.pageX - width/2) / width;
		var distance_height = Math.abs(e.pageY - height/2) / height;
		var distance = Math.sqrt(Math.pow(distance_height, 2) + Math.pow(distance_width, 2));
		$('.background-wrapper').css('-webkit-filter', 'blur(' + Math.floor(distance * 20) + 'px)');
		$('.background-wrapper').css('-webkit-transform', 'scale(' + (1 + distance * 0.75) + ')');
	});
});