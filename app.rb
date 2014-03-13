require './lib/randomtasks.rb'

require 'sinatra'
require 'json'
require 'yaml'

set :public_folder, File.dirname(__FILE__) + '/static'
images = YAML::load_file('config/images.yml')
tasks = YAML::load_file('config/tasks.yml')

get '/' do
  image = RandomTasks::BackgroundImage::from_hash(images.sample)
  haml :index, :locals => {:task => nil, :image => image}
end

get '/task.?:format?' do |format|
  task = RandomTasks::Task::from_hash(tasks.sample)
  task.image = RandomTasks::BackgroundImage::from_hash(images.sample)

  if format == 'json'
    content_type :json
    task.to_json
  else 
    haml :index, :locals => {:task => task, :image => task.image}
  end
end