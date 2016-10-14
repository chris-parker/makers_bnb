ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require 'pony'
require 'stripe'

require_relative 'server'
require_relative 'controllers/sign_up'
require_relative 'controllers/log_in'
require_relative 'data_mapper_setup'
require_relative 'controllers/new_space'
require_relative 'controllers/request'
require_relative 'controllers/spaces'
require_relative 'controllers/user_spaces'
require_relative 'controllers/homepage'
require_relative 'controllers/booking'
require_relative 'controllers/payment'
require_relative 'models/email'

class MakersBNB < Sinatra::Base
set :public_folder, proc {File.join(root)}

  get '/' do
    send_file 'index.html'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
