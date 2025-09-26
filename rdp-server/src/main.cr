require "http/server"
require "http/web_socket"

ws_handler = HTTP::WebSocketHandler.new do |ws, ctx|
  ws.on_ping { ws.pong ctx.request.path }

  ws.on_message do |message|
    puts "received: " + message
  end

  ws.on_close do
    puts "connection closed"
  end
end

server = HTTP::Server.new([ws_handler])

server.bind_tcp "0.0.0.0", 8080

puts "Server started on port 8080. Press Ctrl+C to exit."

Signal::INT.trap do
  puts "Shutting down..."
  server.close
end

server.listen

puts "Server stopped."
