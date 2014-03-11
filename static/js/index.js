// Generated by CoffeeScript 1.6.2
(function() {
  $($(function() {
    var $body;

    $body = $('body');
    return $body.mousemove(function(e) {
      var distance, distance_height, distance_width, height, width;

      width = $body.width();
      height = $body.height();
      distance_width = Math.abs(e.pageX - width / 2) / width;
      distance_height = Math.abs(e.pageY - height / 2) / height;
      distance = Math.sqrt(Math.pow(distance_height, 2) + Math.pow(distance_width, 2));
      return $('.background-wrapper').css('-webkit-filter', 'blur(' + Math.floor(distance * 10) + 'px)').css('-webkit-transform', 'scale(' + (1 + distance * 0.5) + ')');
    });
  }));

}).call(this);
