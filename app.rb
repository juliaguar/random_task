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
  background_images = 
  [
    'http://farm8.staticflickr.com/7236/7304720350_0c64e0c6d6_h.jpg',
    'http://farm5.staticflickr.com/4113/5078240014_cf747d41ef_o.jpg',
    'http://farm5.staticflickr.com/4019/5078240448_b908bbb89e_o.jpg',
    'http://farm8.staticflickr.com/7165/6459391267_d97502c4f7_o.jpg',
    'http://farm9.staticflickr.com/8244/8651612579_8c0e4dede7_k.jpg',
    'http://farm5.staticflickr.com/4108/5077645173_afc0c0a6c3_o.jpg',
    'http://farm5.staticflickr.com/4089/5191751684_f6d177b2a0_o.jpg'
  ]

  good_probability = 20
  random_num = rand(100)  

  task = if random_num > good_probability
    RandomTasks::Task.new(bad.sample, false, 10)
  else
    RandomTasks::Task.new(good.sample, true, 6)
  end

  task.image = background_images.sample

  if format == 'json'
    content_type :json
    task.to_json
  else 
    haml :index, :locals => {:task => task}
  end
end