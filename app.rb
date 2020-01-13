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
    @info = [@project.title, 'page']
    erb :projects_ID
end
post '/projects/:id' do
    params[:project_id] = params[:id]
    Volunteer.new(params).save
    redirect to "/projects/#{params[:id]}"
end

get '/projects/:id/edit' do
    @project = Project.find(params[:id].to_i)
    @info = [@project.title, 'page']
    erb :projects_ID_edit
end
patch '/projects/:id' do
    Project.find(params[:id].to_i).update(params)
    redirect to "/projects/#{params[:id]}"
end
delete '/projects/:id' do
    Project.find(params[:id].to_i).delete
    redirect to '/'
end



get '/projects/:id/volunteers/:vol_id' do
    @volunteer = Volunteer.find(params[:vol_id].to_i)
    @project = Project.find(params[:id].to_i)
    @info = [@volunteer.name, 'page']
    erb :volunteers_ID
end
patch '/projects/:id/volunteers/:vol_id' do
    Volunteer.find(params[:vol_id].to_i).update(params)
    redirect to "/projects/#{params[:id]}/volunteers/#{params[:vol_id]}"
end
delete '/projects/:id/volunteers/:vol_id' do
    Volunteer.find(params[:vol_id].to_i).delete
    redirect to "/projects/#{params[:id]}"
end
