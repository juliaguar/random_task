require './lib/randomtasks.rb'

require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  haml :index, :locals => {:task => nil}
end

get '/task.?:format?' do |format|
  #return good or bad task
  good = ["duolingo", "fuck", "kiss", "play", "Portal"]
  bad = ["clean something", "do sports", "eat apple", "do Uni", "call mum", "go to bed"]

  good_probability = 20
  random_num = rand(100)  

  task = if random_num > good_probability
    RandomTasks::Task.new(bad.sample, false, 15)
  else
    RandomTasks::Task.new(good.sample, true, 10)
  end

  if format == 'json'
    task.to_json
  else 
    haml :index, :locals => {:task => task}
  end
end