require 'sinatra'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  haml :index, :locals => {:task => '', :bg_color => '#333'}
end

get '/task' do
  #return good or bad task
  good = ["duolingo", "fuck", "kiss", "play", "Portal"]
  bad = ["clean something", "do sports", "eat apple", "do Uni", "call mum", "go to bed"]

  good_probability = 20
  random_num = rand(100)

  if random_num > good_probability
    task = bad.sample
    bg_color = '#B32B2B'
  else
    task = good.sample
    bg_color = '#228F22'
  end

    haml :index, :locals => {:task => task, :bg_color => bg_color}
end
