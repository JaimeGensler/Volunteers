require 'sinatra'
require 'sinatra/reloader'
require './lib/volunteer'
require './lib/project'
require 'pry'
require 'pg'

DB = PG.connect({:dbname => 'volunteer_tracker'})
also_reload 'lib/**/*.rb'

get '/' do
    @info = ['Home', 'home']
    erb :index
end

get '/theatres' do
    @page = 'Theatres'
    @css = 'list'
    @theatres = Theatre.all
    erb :theatres
end

get '/theatres/new' do
    @page = 'New Theatre'
    @css = 'new'
    erb :theatres_new
end
post '/theatres' do
    Theatre.new(params).save
    redirect to '/theatres'
end

get '/theatres/:id' do
    @theatre = Theatre.find(params[:id].to_i)
    @page = @theatre.name
    @css = 'item_view'
    erb :theatres_ID
end

get '/theatres/:id/edit' do
    @theatre = Theatre.find(params[:id].to_i)
    @page = "Editing #{@theatre.name}"
    @css = 'item_edit'
    erb :theatres_ID_edit
end
patch '/theatres/:id' do
    theatre = Theatre.find(params[:id].to_i)
    theatre.update(params)
    unless (params[:movie_name] == '' || params[:showtime] == '')
        theatre.add_showing(params[:movie_name], params[:showtime])
    end
    redirect to "/theatres/#{params[:id]}"
end
delete '/theatres/:id' do
    Theatre.find(params[:id].to_i).delete
    redirect to '/theatres'
end

#classes are constants so set a variable equal to the type

# movie routes



get '/movies' do
    @page = 'Movies'
    @css = 'list'
    @movies = Movie.all
    erb :movies
end

get '/movies/new' do
    @page = 'New Movie'
    @css = 'new'
    erb :movies_new
end
post '/movies' do
    Movie.new(params).save
    redirect to '/movies'
end

get '/movies/:id' do
    @movie = Movie.find(params[:id].to_i)
    @page = @movie.name
    @css = 'item_view'
    erb :movies_ID
end

get '/movies/:id/edit' do
    @movie = Movie.find(params[:id].to_i)
    @page = "Editing #{@movie.name}"
    @css = 'item_edit'
    erb :movies_ID_edit
end
patch '/movies/:id' do
    Movie.find(params[:id].to_i).update(params)
    redirect to "/movies/#{params[:id]}"
end
delete '/movies/:id' do
    Movie.find(params[:id].to_i).delete
    redirect to '/movies'
end
