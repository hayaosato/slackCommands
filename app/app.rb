require 'sinatra'
require './app/ruby_search'

post '/slack/command' do
  crawler = Crawl.new
  text = crawler.get_status_code(params[:text])
  text
end

