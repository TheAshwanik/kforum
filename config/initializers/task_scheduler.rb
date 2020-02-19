require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

scheduler.every '2m' do
   require "net/http"
   require "uri"
   if connection.adapter_name == 'PostgreSQL'
      url = 'http://kforum.ashwani.co.in'
   else
      url = 'http://localhost:3000'
   end
   
   Net::HTTP.get_response(URI.parse(url))
end