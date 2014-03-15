$($ ->
    $body = $('body')
    current_task = null

    # ipad scroll fix
    $(document).bind 'touchmove', false;

    save_task = (task) ->
        localStorage.task = JSON.stringify(task)

    check_load_task = () ->
        if localStorage.task
            task = JSON.parse(localStorage.task)
            if task.target_time > Date.now()
                handle_task task
            else
                localStorage.task = ''

    # Intensity should be a value between 0 and 1
    set_background_blur = (intensity) ->
        $('.background-wrapper')
            .css('-webkit-filter', 'blur(' + (intensity * 10).toFixed(4) + 'px)')
            .css('-webkit-transform', 'scale(' + (1 + intensity * 0.5).toFixed(4) + ')')

    format_time = (total_seconds) ->
        seconds = total_seconds % 60
        minutes = Math.floor(total_seconds / 60)
        seconds = '0' + seconds if seconds < 10
        minutes = '0' + minutes if minutes < 10
        "#{minutes}:#{seconds}"

    update_countdown = () ->
        seconds_left = Math.round((current_task.target_time - Date.now()) / 1000)
        $('#timer-countdown').text format_time(seconds_left)
        set_background_blur(seconds_left / current_task.time)
        if seconds_left > 0
            window.setTimeout(update_countdown, 100)
        else
            $('#bell').get(0).play();
            $('#taskbutton').show()
            $('#timer').hide()

    handle_task = (task) ->
            $('#timer').show()
            $('#taskdisplay').text task.title
            $('.background-wrapper').css('background-image', 'url(' + task.image.url + ')')
            $('#imagecredits').html(task.image.credits)
            $('#taskbutton').hide()
            if not task.target_time
                task.target_time = Date.now() + task.time * 1000
            current_task = task
            save_task task
            update_countdown()

    $('#taskbutton').click(
        (e) ->
            e.preventDefault()
            $.getJSON('/task.json', (task) ->
                handle_task task
            )
    )

    check_load_task()
    share_options =
        color: 'rgba(255,255,255,0.9)'
        text_font: false
        background: 'rgba(255,255,255,0.0)'
        icon: 'paper-plane'
    $('.share').share share_options
)
