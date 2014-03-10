require 'sinatra'

get '/' do
  haml :index, :locals => {:task => ''}
end

get '/task' do
  #return good or bad task
  good = ["duolingo", "fuck", "kiss", "play", "Portal"]
  bad = ["clean something", "do sports", "eat apple", "do Uni", "call mum", "go to bed"]

  good_probability = 20
  random_num = rand(100)

  task = if random_num > good_probability
      bad.sample
    else
     good.sample
    end

    haml :index, :locals => {:task => task}
end
