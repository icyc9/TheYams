require 'sinatra'

class Server < Sinatra::Base
  set :public, 'public'

  get '/' do
    send_file 'views/index.html'
  end

  post '/emails' do
    fan = { name: params[:name], email: params[:email] }

#   Google.subscribe! fan

    send_file 'views/thanks.html'
  end
end
