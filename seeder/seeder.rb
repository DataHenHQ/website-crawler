require 'uri'

starting_url = ENV['starting_url']

def valid_url?(uri_string)
  uri = URI(uri_string)
  true
rescue URI::InvalidURIError
  false
end

if valid_url?(starting_url)

  pages << {
    page_type: 'pages', 
    method: "GET",
    url: starting_url 
  }  

else
  raise "Invalid starting_url: #{starting_url}, must provide a Valid URL like https://www.example.com/"
end

