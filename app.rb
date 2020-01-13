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


# get '/theatres/:id' do
#     @theatre = Theatre.find(params[:id].to_i)
#     @page = @theatre.name
#     @css = 'item_view'
#     erb :theatres_ID
# end
#
# get '/theatres/:id/edit' do
#     @theatre = Theatre.find(params[:id].to_i)
#     @page = "Editing #{@theatre.name}"
#     @css = 'item_edit'
#     erb :theatres_ID_edit
# end
# patch '/theatres/:id' do
#     theatre = Theatre.find(params[:id].to_i)
#     theatre.update(params)
#     unless (params[:movie_name] == '' || params[:showtime] == '')
#         theatre.add_showing(params[:movie_name], params[:showtime])
#     end
#     redirect to "/theatres/#{params[:id]}"
# end
# delete '/theatres/:id' do
#     Theatre.find(params[:id].to_i).delete
#     redirect to '/theatres'
# end
