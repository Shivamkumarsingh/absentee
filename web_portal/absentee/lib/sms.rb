require "rubygems"
require "net/https"
require "uri"
require "json"

class Sms
  def self.send(mobile_numbers)
    requested_url = 'https://api.textlocal.in/send/?'

    uri = URI.parse(requested_url)
    http = Net::HTTP.start(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    mobile_numbers.each do |mob|
      number = '91' + mob.to_s
      res = Net::HTTP.post_form(uri, 'apikey' => 'gRdMgsFy72o-Vr5hjEa7o1oYEIjso74dGjXPnjcyvu', 'message' => 'Your ward did not come to school today. - Josh Public School',
        'sender' => 'TXTLCL', 'numbers' => number)
      response = JSON.parse(res.body)
      puts (response)
    end
  end
end
