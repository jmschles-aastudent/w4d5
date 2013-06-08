require 'debugger'
require 'webrick'
require_relative 'rails_lite/controller_base'

class MyController < ControllerBase

	def go
		# debugger
		if @req.path == '/redirect' 
			redirect_to('http://www.google.com')
		end
	end

end

root = '/'
server = WEBrick::HTTPServer.new(
		:Port => 8080,
		:DocumentRoot => root
	)

server.mount_proc root do |req, res|

	controller = MyController.new(req, res)

	controller.go
	
end


trap('INT') { server.shutdown }

server.start