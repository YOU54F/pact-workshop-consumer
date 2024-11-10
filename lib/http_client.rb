require "httparty"
require "uri"

class HttpClient
  def get(url)
    HTTParty.get(url)
  end
end
