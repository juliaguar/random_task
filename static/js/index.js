$(function() {
	$('body').mousemove(function(e) {
		$height = $('body').width();
		$('.background-wrapper').css('-webkit-filter', 'blur(' + Math.floor(Math.abs(e.pageX - $height/2) / $height * 20) + 'px)');
		console.log("move");
	});
});