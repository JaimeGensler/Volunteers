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
    @projects = Project.all
    erb :index
end
post '/' do
    Project.new(params).save
    redirect to '/'
end

get '/projects/:id' do
    @project = Project.find(params[:id].to_i)
    @info = [@project.title, 'project']
    erb :projects_ID
end
patch '/projects/:id' do
    Project.find(params[:id].to_i).update(params)
    redirect to "/projects/#{params[:id]}"
end

get '/projects/:id/edit' do
    @project = Project.find(params[:id].to_i)
    @info = [@project.title, 'project']
    erb :projects_ID_edit
end
patch '/projects/:id' do
    Project.find(params[:id].to_i).update(params)
    redirect to "/projects/#{params[:id]}"
end
# delete '/theatres/:id' do
#     Theatre.find(params[:id].to_i).delete
#     redirect to '/theatres'
# end
