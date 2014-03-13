require './lib/randomtasks.rb'

require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  image = RandomTasks::BackgroundImage::random
  haml :index, :locals => {:task => nil, :image => image}
end

get '/task.?:format?' do |format|
  #return good or bad task
  good = ["duolingo", "fuck", "kiss", "play", "Portal"]
  bad = ["clean something", "do sports", "eat apple", "do Uni", "call mum", "go to bed"]

  good_probability = 20
  random_num = rand(100)  

  task = if random_num > good_probability
    RandomTasks::Task.new(bad.sample, false, 10)
  else
    RandomTasks::Task.new(good.sample, true, 6)
  end

  task.image = RandomTasks::BackgroundImage::random

  if format == 'json'
    content_type :json
    task.to_json
  else 
    haml :index, :locals => {:task => task, :image => task.image}
  end
end