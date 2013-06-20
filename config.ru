require 'rack'

class FirstApp
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
  end
end

class FirstMiddleware
  def initialize(app)
    @app = app
  end

  def change_name(name)
    name.join('').gsub(/Rack/, "Erie.rb")
  end

  def call(env)
    puts env
    code, headers, body = @app.call(env)
    [code, headers, [change_name(body)]]
  end
end

use FirstMiddleware
run FirstApp.new
