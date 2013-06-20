require 'rack'
require 'slim'
use Rack::Reloader

class FirstMiddleware
  def initialize(app)
    @app = app
  end

  def change_name(name)
    name.join('').gsub(/Rack/, "Erie.rb")
  end

  def call(env)
    code, headers, body = @app.call(env)
    [code, headers, [change_name(body)]]
  end
end

class Response
  def initialize(body, code = 200, headers = {})
    @code    = code
    @headers = {"Content-Type" => "text/html"}.merge(headers)
    @body    = [body]
  end

  def call(env)
    [@code, @headers, @body]
  end
end

use FirstMiddleware

map '/' do
  run Response.new "Hello, World!"
end

map '/about' do
  run Response.new "Hello, About!"
end

map '/change' do
  run Response.new "Hello, Rack!"
end

map '/page' do
  @name = "Ruby!"
  run Response.new Slim::Template.new('./views/index.slim').render(self)
end

map '/env' do
  run lambda { |env| Response.new(env.inspect).call(env) }
end

