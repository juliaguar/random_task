require 'sinatra'
require 'sinatra/respond_with'

get '/' do
  respond_with :index, :task => ''
end

get '/task', :provides => [:html, :json] do
  #return good or bad task
  good = ["duolingo", "fuck", "kiss", "play", "Portal"]
  bad = ["clean something", "do sports", "eat apple", "do Uni", "call mum"]

  good_probability = 20
  random_num = rand(100)

  task = if random_num > good_probability
      bad.sample
    else
     good.sample
    end

    respond_with :index, :task => task
end
