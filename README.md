random_task
===========

deployed at:
http://randomtask.herokuapp.com/

Do run the app, you need to have a mongodb running at `mongodb://localhost/randomtasks` with two collections being `images` and `tasks` containing information about the tasks and background images.

To create the javascript and css build files we use gulp. If you don't have gulp installed use

    npm install gulp -g

After that you can install the gulp dependencies via

    npm install

To then create the static files run

    gulp

To actually run the app start it with foreman

    foreman start
