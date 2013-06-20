require 'rack'

class FirstApp
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["Hello Rack!"]]
  end
end

run FirstApp.new
