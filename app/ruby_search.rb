require 'mechanize'
require 'dotenv'
require 'pry'

Dotenv.load

class Crawl
  def initialize()
    # @url = 'http://rurema.clear-code.com/query:'
    @url = ''
    @agent = Mechanize.new
    @agent.user_agent_alias = 'Mac Mozilla'
    @title = ''
    #@versions = ''
    @versions = []
    @types = []
    @summary = ''
    @snippet = ''
  end

  def get_status_code( index_word )
    @url = "http://rurema.clear-code.com/query:#{index_word}"
    begin
      status_code = @agent.get(@url).code.to_i
      if status_code == 200
        ruby_search( index_word )
      else
        text = "見つかりませんでした。検索条件を変えてみませんか？"
        return text
      end
    rescue Mechanize::ResponseCodeError => error
      text = "見つかりませんでした。検索条件を変えてみませんか？"
      return text
    end

  end

  def ruby_search( index_word )
    # sleep(3)
    page = @agent.get(@url)
    entries = page.css('dl.entries')
    entry_name = entries.css('dt#entry-0')
    @title = entry_name.css('h3').css('span.signature').text.strip

    document = entries.css('dd')[0]
    entry_links = document.css('ul.entry-links')
    entry_links.css('a').each do |version|
      @versions.push(version.text)
    end

    entry_metadata = document.css('ul.entry-metadata')
    entry_metadata.css('a').each do |type|
      @types.push(type.text)
    end

    entry_summary = document.css('div.entry-summary')
    @summary = entry_summary.css('p').text

    entry_snippet = document.css('div.entry-snippets')
    @snippet = entry_snippet.css('div.snippet').text
    text = "#{@title}\n#{@versions}\n#{@types}\n#{@summary}\n```\n#{@snippet}```"
    return text
  end
end

craw = Crawl.new
craw.get_status_code( 'Array' )
