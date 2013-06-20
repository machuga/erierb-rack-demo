require 'rack'
require './router'

router = Router.new

router.map '/' do
  "Hello, World!"
end

router.map '/about' do
  "Hello, About!"
end

router.map '/change' do
  "Hello, Rack!"
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
run router
