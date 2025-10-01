require "http/server"
require "http/web_socket"

ws_handler = HTTP::WebSocketHandler.new do |ws, ctx|
  ws.on_ping { ws.pong ctx.request.path }

  ws.on_message do |message|
    puts "received: " + message

    # Run ffmpeg for taking screenshot
    Process.run("ffmpeg", args: ["-f", "x11grab", "-i", ":0.0", "-vframes", "1", "-q:v", "2", "screenshot.jpg", "-y"], output: IO:Memory.new, error: IO:Memory.new)

    # read image as binary
    bytes = File.read_bytes("screenshot.jpg")
    puts "read image as binary!"

    # send to client
    ws.send(bytes)
    puts "send image to client"
  End

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
