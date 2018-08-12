require 'sinatra'
require './app/ruby_search'

post '/slack/command' do
  crawler = Crawl.new
  text = crawler.ruby_search(params[:text])
  text
end

