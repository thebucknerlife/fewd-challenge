require 'sinatra'
require 'json'

get '/' do
  File.read('views/index.html')
end

get '/favorites' do
  @movies = JSON.parse(File.read('data.json'))
  erb :favorites
end

post '/favorites' do
  return 'Invalid Request' unless params[:name] && params[:oid]
  file = JSON.parse(File.read('data.json'))
  new_movie = { name: params[:name], oid: params[:oid] }
  file << new_movie
  File.write('data.json', JSON.pretty_generate(file))
  return new_movie.to_json
end
