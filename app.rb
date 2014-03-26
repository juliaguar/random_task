require './lib/randomtasks.rb'

require 'sinatra'
require 'json'
require 'yaml'

set :public_folder, File.dirname(__FILE__) + '/static'
config = YAML::load_file('config/config.yml')[settings.environment]
storage = RandomTasks::Storage.new(config['db_uri'])
RandomTasks::Collection::set_storage(storage)
background_images = RandomTasks::Collection.new(RandomTasks::BackgroundImage, 'images')
tasks = RandomTasks::Collection.new(RandomTasks::Task, 'tasks')

get '/' do
  image = background_images.get_random
  haml :index, :locals => {:task => nil, :image => image}
end

get '/task.?:format?' do |format|
  task = tasks.get_random
  task.image = background_images.get_random
  task.time = config['task_time']

  if format == 'json'
    content_type :json
    task.to_json
  else 
    haml :index, :locals => {:task => task, :image => task.image}
  end
end