$($ ->
    current_task = null
    next_task = null

    # ipad scroll fix
    $(document).bind 'touchmove', false;

    # Saves task to allow refresh
    save_task = ->
        localStorage.task = JSON.stringify(current_task)

    # Load saved task if possible
    load_saved_task = ->
        if localStorage.task
            task = JSON.parse(localStorage.task)
            if task.target_time > Date.now()
                current_task = task
                continue_task()
            else
                localStorage.task = ''

    # Preload the next task
    load_next_task = ->
        $.getJSON('/task.json', (task) ->
            next_task = task
            # preload background image
            bg_image = new Image()
            bg_image.src = task.image.url
        )

    # Change the abckground blur
    # Intensity should be a value between 0 and 1
    set_background_blur = (intensity) ->
        $('.background-wrapper')
            .css('-webkit-filter', 'blur(' + (intensity * 10).toFixed(4) + 'px)')
            .css('-webkit-transform', 'scale(' + (1 + intensity * 0.5).toFixed(4) + ')')

    # Format time into mm:ss
    format_time = (total_seconds) ->
        seconds = total_seconds % 60
        minutes = Math.floor(total_seconds / 60)
        seconds = '0' + seconds if seconds < 10
        minutes = '0' + minutes if minutes < 10
        "#{minutes}:#{seconds}"

    # Update the countdown periodically
    update_countdown = ->
        seconds_left = Math.round((current_task.target_time - Date.now()) / 1000)
        $('#timer-countdown').text format_time(seconds_left)
        set_background_blur(seconds_left / current_task.time)
        if seconds_left > 0
            window.setTimeout(update_countdown, 100)
        else
            $('#bell').get(0).play();
            $('#taskbutton')
                .show()
                .text('Another one?')
            $('#timer').hide()

    # Start the countdown of the task
    start_task = ->
        $('#timer').show()
        if not current_task.target_time
            current_task.target_time = Date.now() + current_task.time * 1000
        save_task()
        update_countdown()

    # Continue a saved task
    continue_task = ->
        display_task()
        $('#timer').show()
        $('#taskbutton').hide()
        update_countdown()

    # Switch to the ready state
    ready_task = ->
        $('#taskbutton').hide()
        $('#starttaskbutton').show()


    # Display the current_task
    display_task = ->
        $('#taskdisplay').text current_task.title
        $('.background-wrapper').css('background-image', 'url(' + current_task.image.url + ')')
        $('#imagelicense')
            .html(current_task.image.license.html_string)
            .attr('href', current_task.image.license.url)
        $('#imageauthor')
            .text(current_task.image.author_name)
            .attr('href', current_task.image.author_url)


    $('#taskbutton').click(
        (e) ->
            e.preventDefault()
            current_task = next_task
            display_task()
            ready_task()
    )

    $('#starttaskbutton').click(
        (e) ->
            e.preventDefault()
            $('#starttaskbutton').hide()
            start_task()
            load_next_task()
    )

    load_saved_task()
    load_next_task()

    # Share Button Plugin
    share_options =
        color: 'rgba(255,255,255,0.9)'
        text_font: false
        background: 'rgba(255,255,255,0.0)'
        icon: 'paper-plane'
    $('.share').share share_options
)
