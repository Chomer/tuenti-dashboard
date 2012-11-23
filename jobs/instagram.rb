require 'net/http'
require 'json'
require "net/https"
require "uri"


# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '10s', :first_in => 0 do |job|

	uri = URI.parse("https://api.instagram.com/v1/tags/tuenti/media/recent?access_token=2367873.f59def8.c05239e7e43846788fbcf2f57c58d64a")
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	request = Net::HTTP::Get.new(uri.request_uri)

	response = http.request(request)

	photos = JSON.parse(response.body)["data"]
	n = rand(photos.length)

	# if photos[0]
 #    photos[0].map! do |photo| 
 #      { iname: photo['user']['username'], iphoto: photo['images']['low_resolution']['url'] }
 #    end
  
 #    send_event('instagram', photos )
 #    #send_event('instagram', iname: response.body )
 #  end
 
	send_event('instagram', { iname: photos[n]['user']['username'], itext: photos[n]['caption']['text'], iphoto: photos[n]['images']['low_resolution']['url'] } )

  #send_event('instagram', { iname: "Marcio", itext: "Lorem Ipsum Dolor sit amet", iphoto: "http://distilleryimage0.s3.amazonaws.com/fdb2fca8333311e2aa0322000a1fa408_7.jpg" })
end
