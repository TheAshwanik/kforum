require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.every '2m' do
   require "net/http"
   require "uri"
   url = 'http://kforum.ashwani.co.in'
   Net::HTTP.get_response(URI.parse(url))
end