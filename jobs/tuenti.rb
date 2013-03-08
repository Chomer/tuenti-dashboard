require 'net/http'
require 'json'
require "net/https"
require "uri"

current_chat_messages_pr0_1day = 0
current_chat_messages_cup_1day = 0
current_active_users_pr0_1day = 0
current_active_users_cup_1day = 0
current_profile_views_pr0_1day = 0
current_profile_views_cup_1day = 0

SCHEDULER.every '1d', :first_in => 0 do |job|

	uri = URI.parse("http://10.222.0.2/desktop/growth/cupcake_kpi_global_dashboard.json")
	response = Net::HTTP.get_response(uri)
	data = JSON.parse(response.body)

	last_chat_messages_pr0_1day = current_chat_messages_pr0_1day
	last_chat_messages_cup_1day = current_chat_messages_cup_1day
	last_active_users_pr0_1day = current_active_users_pr0_1day
	last_active_users_cup_1day = current_active_users_cup_1day
	last_profile_views_pr0_1day = current_profile_views_pr0_1day
	last_profile_views_cup_1day = current_profile_views_cup_1day

	current_chat_messages_pr0_1day = data["chat_messages_pr0_1day"]
	current_chat_messages_cup_1day = data["chat_messages_cup_1day"]
	current_active_users_pr0_1day = data["active_users_pr0_1day"]
	current_active_users_cup_1day = data["active_users_cup_1day"]
	current_profile_views_pr0_1day = data["profile_views_pr0_1day"]
	current_profile_views_cup_1day = data["profile_views_cup_1day"]


  send_event('chat_messages_pr0_1day', { current: current_chat_messages_pr0_1day, last: last_chat_messages_pr0_1day } )
  send_event('chat_messages_cup_1day', { current: current_chat_messages_cup_1day, last: last_chat_messages_cup_1day } )
  send_event('active_users_pr0_1day',  { current: current_active_users_pr0_1day,  last: last_active_users_pr0_1day } )
  send_event('active_users_cup_1day',  { current: current_active_users_cup_1day,  last: last_active_users_cup_1day } )
  send_event('profile_views_pr0_1day', { current: current_profile_views_pr0_1day,  last: last_profile_views_pr0_1day } )
  send_event('profile_views_cup_1day', { current: current_profile_views_cup_1day,  last: last_profile_views_cup_1day } )
end
