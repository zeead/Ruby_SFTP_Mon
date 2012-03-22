#!/usr/bin/ruby

require 'rubygems'
require 'net/ssh'
require 'net/sftp'

# Initiate SFTP Authentication
Net::SFTP.start('e1', 'ec2-user', { :auth_methods => %w{ publickey}}) do |sftp|
# Upload a file from the local system to the remote system
sftp.upload!("/tmp/file3.txt", "/home/ec2-user/file3.txt")
Net::SSH.start('e1', 'ec2-user', { :auth_methods => %w{ publickey}}) do |ssh|
puts ssh.exec!("ls -la /home/ec2-user/file3.txt")
puts ssh.exec!("cat file3.txt")
end 
end


