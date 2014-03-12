// Generated by CoffeeScript 1.6.2
(function() {
  $($(function() {
    var $body, handle_task, setBackgroundBlur, task_countdown, update_countdown;

    $body = $('body');
    setBackgroundBlur = function(intensity) {
      return $('.background-wrapper').css('-webkit-filter', 'blur(' + Math.floor(intensity * 10) + 'px)').css('-webkit-transform', 'scale(' + (1 + intensity * 0.5) + ')');
    };
    if (window.DeviceOrientationEvent) {
      window.addEventListener('deviceorientation', function(e) {
        return setBackgroundBlur(e.alpha / 360);
      });
    }
    $body.mousemove(function(e) {
      var distance, distance_height, distance_width, height, width;

      width = $body.width();
      height = $body.height();
      distance_width = Math.abs(e.pageX - width / 2) / width;
      distance_height = Math.abs(e.pageY - height / 2) / height;
      distance = Math.sqrt(Math.pow(distance_height, 2) + Math.pow(distance_width, 2));
      return setBackgroundBlur(distance);
    });
    task_countdown = 0;
    update_countdown = function() {
      $('#countdown').text(task_countdown + ' seconds');
      if (task_countdown > 0) {
        task_countdown -= 1;
        return window.setTimeout(update_countdown, 1000);
      } else {
        $('#taskbutton').show();
        return $('#countdown').text('');
      }
    };
    handle_task = function(task) {
      $('#taskdisplay').text(task.title);
      $('#taskbutton').hide();
      task_countdown = task.time;
      return update_countdown();
    };
    return $('#taskbutton').click(function(e) {
      e.preventDefault();
      return $.getJSON('/task.json', function(task) {
        return handle_task(task);
      });
    });
  }));

}).call(this);
