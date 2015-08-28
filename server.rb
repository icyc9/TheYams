require 'sinatra'

class Server < Sinatra::Base
  set :public, 'public'

  get '/' do
    send_file 'views/index.html'
  end

  post '/emails' do
    erb :index, locals: { name: params[:name], email: params[:email] }
  end
end
