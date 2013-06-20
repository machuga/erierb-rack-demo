class Router
  def initialize
    @routes = {}
    @code = 200
    @headers = {"Content-Type" => "text/html"}
  end

  def map(path, code = @code, headers = @headers, &block)
    @routes[path.to_s] = [code, headers, [block.call]]
  end

  def call(env)
    match = no_route
    match = @routes[env['REQUEST_PATH']] if @routes.has_key? env['REQUEST_PATH']
    match
  end

  private

  def no_route
    [404, {"Content-Type" => "text/html"}, ["Page Not Found"]]
  end
end
