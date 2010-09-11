require 'net/https'
require 'uri'

class Instapaper

  API_URL = "https://www.instapaper.com/api"

  RESPONSE_CODES = { 
    200 => "Authentication successful",
    201 => "The URL was added to Instapaper",
    400 => "Bad request, did you specify a URL to add?",
    403 => "Invalid username and/or password",
    500 => "The service encountered an error"
  }

  def initialize(username = nil, password = nil)
    @params = { 'username' => username, 'password' => password }
  end

  def authenticate
    url = "#{API_URL}/authenticate" 
    request = perform_request(url)
    handle_response(request.code)
  end

  def add(url_to_add = nil, title = nil, selection = nil )
    url = "#{API_URL}/add"
    @params.merge!(
      'url' => url_to_add, 'title' => title, 'selection' => selection
    )
    request = perform_request(url)
    handle_response(request.code)
  end

  private

  def perform_request(url)
    uri = URI.parse(url)

    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(@params)

    http = Net::HTTP.new(uri.host, uri.port)
    if uri.scheme == "https"
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    result = http.start {|http| http.request(request)}
  end
  
  def handle_response(code)
    response = RESPONSE_CODES.select {|key, value| key == code.to_i }.flatten
    { :code => response[0], :message => response[1] }
  end
end