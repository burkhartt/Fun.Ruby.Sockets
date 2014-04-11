require 'socket'
load 'rc4.rb'

rc4 = RC4.new("mysupersecretkeyshhdonttellanyone")

port = 10102

a = TCPServer.new(port)
puts "starting on port #{port}"
loop {                         # Servers run forever
  connection = a.accept
  message = connection.recv(1024)
  puts "received #{message}"
  puts "encrypting..."
  encrypted_message = rc4.encrypt(message)
  puts "encrypted message: #{encrypted_message}"
  puts "sending encrypted message"
  connection.write(encrypted_message)
  puts "sent"

  partially_encrypted_message = connection.recv(1024)
  puts "received #{partially_encrypted_message}"
  decrypted_message = rc4.decrypt(message)
  puts "you clearly did not write this: #{decrypted_message}"
  connection.close
}