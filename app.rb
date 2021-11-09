require "rack"

class App
  def call(env)
    if env["PATH_INFO"] == "/" && env["REQUEST_METHOD"] == "GET"
      [200, {}, ["Hello world"]]
    else
      [404, {}, ["Rack says the page you are looking for cannot be found"]]
    end
  end
end
