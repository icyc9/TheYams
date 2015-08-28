require 'sinatra'

get '/' do
  erb :index
end

post '/emails' do
  erb :index, locals: { name: params[:name], email: params[:email] }
