require 'uri'
require 'json'

class Params
	attr_reader :params

  def initialize(req, route_params)
  	@params = parse_www_encoded_form(req)
  end

  def [](key)
  	@params[key]
  end

  private
  def parse_www_encoded_form(www_encoded_form)
  	query = www_encoded_form.query_string
  	post_data = www_encoded_form.body
  	if query
  		return paramify(query)
  	elsif post_data
  		return paramify(post_data)
  	end
  	{}
  end

  def parse_key(key)
  end

  def paramify(data)
  	params = {}
  	key_value_pairs = URI.decode_www_form(data)
  	key_value_pairs.each do |pair|
  		params[pair.first] = pair.last
  	end
  	params
  end
end




# Long version in case short version fucks up

  # private
  # def parse_www_encoded_form(www_encoded_form)
  # 	params = {}
  # 	query = www_encoded_form.query_string
  # 	post_data = www_encoded_form.body
  # 	if query
	 #  	key_value_pairs = URI.decode_www_form(query)
	 #  	key_value_pairs.each do |pair|
	 #  		params[pair.first] = pair.last
	 #  	end
	 #  elsif post_data
	 #  	key_value_pairs = URI.decode_www_form(post_data)
	 #  	key_value_pairs.each do |pair|
	 #  		params[pair.first] = pair.last
	 #  	end
	 #  end
  # 	params
  # end