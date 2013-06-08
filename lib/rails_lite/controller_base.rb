require 'erb'
require 'active_support/core_ext'
require_relative 'params'
require_relative 'session'

class ControllerBase
  attr_reader :params

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = Params.new(req, route_params).params

    @already_rendered = false
  end

  def session
    @session ||= Session.new(@req)
  end

  def already_rendered?
    @already_rendered
  end

  def redirect_to(url)
    @res.status = 302
    @res.header['location'] = url

    session.store_session(@res)
    @response_built = true
  end

  def render_content(content, type)
    raise "Can't double render" if already_rendered?
    @res.content_type = type
    @res.body = content

    session.store_session(@res)
    @already_rendered = true
  end

  def render(template_name)
    raise "Can't double render" if already_rendered?
    class_name = self.class.to_s.underscore
    # class_name.slice!("_controller")
    target_text = File.read("views/#{class_name}/#{template_name}.html.erb")
    template = ERB.new(target_text)
    b = binding
    content = template.result(b)
    render_content(content, 'text/html')
  end

  def invoke_action(name)
  end
end
