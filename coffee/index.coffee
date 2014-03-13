$($ ->
    $body = $('body')
    current_task = null

        # Intensity should be a value between 0 and 1
    set_background_blur = (intensity) ->
        $('.background-wrapper')
            .css('-webkit-filter', 'blur(' + (intensity * 10).toFixed(4) + 'px)')
            .css('-webkit-transform', 'scale(' + (1 + intensity * 0.5).toFixed(4) + ')')


    update_countdown = () ->
        $('#countdown').text(current_task.countdown + ' seconds')
        set_background_blur(current_task.countdown / current_task.time)
        if current_task.countdown > 0
            current_task.countdown -= 1
            window.setTimeout(update_countdown, 1000)
        else 
            $('#taskbutton').show()
            $('#countdown').text('')

    handle_task = (task) ->
            $('#taskdisplay').text task.title
            $('.background-wrapper').css('background-image', 'url(' + task.image.url + ')')
            $('#imagecredits').html(task.image.credits)
            $('#taskbutton').hide()
            task.countdown = task.time
            current_task = task
            update_countdown()

    $('#taskbutton').click(
        (e) ->
            e.preventDefault()
            $.getJSON('/task.json', (task) ->
                handle_task task
            )
    )
)