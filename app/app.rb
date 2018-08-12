require 'sinatra'

post '/slack/command' do
  #index_word = params[:text]
  # ruby_search(index_word)
  parameters = "```\n" + params[:token] + "\n"
  parameters += params[:command] + "\n"
  parameters += params[:text] + "\n"
  parameters += params[:response_url] + "\n"
  parameters += params[:trigger_id] + "\n"
  parameters += params[:user_id] + "\n"
  parameters += params[:user_name] + "\n"
  parameters += params[:team_id] + "\n"
  parameters += params[:channel_id] + "\n```"
end

def ruby_search(index_word)
  out_put_text = "#{index_word}について検索しました。"
  out_put_text
end
