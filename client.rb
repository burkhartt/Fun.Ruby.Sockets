require 'socket'      # Sockets are in standard library
load 'rc4.rb'

hostname = 'localhost'
port = 10102
key = "yothisismykeydude"

rc4 = RC4.new(key)
puts "connecting..."
s = TCPSocket.new(hostname, port)
puts "connected"
message = "what is up?"
encrypted_message = rc4.encrypt(message)
s.write encrypted_message
server_reply = s.recv(1024)
puts "received: #{server_reply}"
partially_decrypted_message = rc4.decrypt(server_reply)
s.write partially_decrypted_message

puts "I'm going home"
s.close               # Close the socket when done