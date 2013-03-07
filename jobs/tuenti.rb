require 'net/http'
require 'json'

SCHEDULER.every '10m', :first_in => 0 do |job|
	uri = URI.parse("http://10.222.0.2/desktop/growth/cupcake_kpi_global_dashboard.json")

	request = Net::HTTP::Get.new(uri.request_uri)
	response = http.request(request)
	data = JSON.parse(response.body)

	#last_n_chats_pr0_1day = current_n_chats_pr0_1day
	last_n_chats_pr0_1day = 100
	last_n_chats_cup_1day = current_n_chats_cup_1day
	#current_n_chats_pr0_1day = data.chat_messages_pr0_1day
	current_n_chats_pr0_1day = 99
	current_n_chats_cup_1day = data.chat_messages_cup_1day

  send_event('n_chats_pr0_1day', { current: current_n_chats_pr0_1day, last: last_n_chats_pr0_1day })
  send_event('n_chats_cup_1day', { current: current_n_chats_cup_1day, last: last_n_chats_cup_1day })

end
