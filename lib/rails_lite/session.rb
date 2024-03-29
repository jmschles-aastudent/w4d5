require 'json'
require 'webrick'

class Session
  def initialize(req)
  	cookie = req.cookies.find { |cookie| cookie.name == '_rails_lite_app' }
  	(cookie.nil?) ? @data = {} : @data = JSON.parse(cookie.value)
  end

  def [](key)
  	@data[key]
  end

  def []=(key, val)
  	@data[key] = val
  end

  def store_session(res)
  	res.cookies << WEBrick::Cookie.new('_rails_lite_app', @data.to_json)
  end
end
