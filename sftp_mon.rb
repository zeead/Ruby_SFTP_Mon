#!/usr/bin/ruby

require 'rubygems'
require 'net/ssh'
require 'net/sftp'
require 'filesystemwatcher'

def sftp_push(path_one, path_two)
  # Initiate SFTP Authentication
   Net::SFTP.start('e1', 'ec2-user', { :auth_methods => %w{ publickey}}) do |sftp|
# Upload a file from the local system to the remote system
   sftp.upload!(path_one, path_two)
   end
end

watcher = FileSystemWatcher.new()
watcher.addDirectory("/opt/RACF/DATA", "*.txt")
watcher.sleepTime = 5
watcher.start { |status,file|
    if(status == FileSystemWatcher::CREATED) then
        puts "created: #{file}"
        path_one = "#{file}"
        path_two = "#{file}"
        sftp_push(path_one, path_two)
    elsif(status == FileSystemWatcher::MODIFIED) then
        puts "modified: #{file}"
    elsif(status == FileSystemWatcher::DELETED) then
        puts "deleted: #{file}"
    end
}
watcher.join()