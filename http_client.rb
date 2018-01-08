module Client
  def self.new(url)
    client = HTTPClient.new
    client.debug_dev = $stderr
    Faraday.new(:url => url) do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
