require 'thin'
require 'sinatra/base'
require 'em-websocket'

EventMachine.run do
  class MakersBNB < Sinatra::Base

    get '/chat' do
      if current_user
        @username = current_user.username
      else
        @username = "Anonymous"
      end
      erb :'chat/chat'
    end

    @clients = []

    EM::WebSocket.start(:host => '0.0.0.0', :port => '3001') do |ws|
      ws.onopen do |handshake|
        @clients << ws
        ws.send "Connected to #{handshake.path}."
      end

      ws.onclose do
        ws.send "Closed."
        @clients.delete ws
      end

      ws.onmessage do |msg|
        puts "Received Message: #{msg}"
        @clients.each do |socket|
          socket.send msg
        end
      end
    end
  end

  MakersBNB.run! :port => 3000

end
