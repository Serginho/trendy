require 'rss'
require 'thread'
require 'nokogiri'
require 'em-http'

module Wrapper

  THREADS = 5

  class Wr

    def initialize threads
      @requests = []
      @feeds = Queue.new
      @num_threads = threads
      @finish = false
      @threads = []
      @sources = Source.all.select "id,url"
      @num_sources = @sources.length
    end

    def start
      EventMachine.run do

        puts 'Opening connections...'
        @sources.each do |source|
          options = {redirects: 3}
          http = EventMachine::HttpRequest.new(source.url).get options
          http.callback do
            begin
              feed = RSS::Parser.parse(http.response)
              unless feed.nil? then
                @feeds.push [feed, source]
              end
            rescue Exception
              puts "Source #{source.url} failed to parse"
            end
            @num_sources -= 1
            if @num_sources < 1 then
              @feeds.push :finish
              EventMachine.add_shutdown_hook do
                @threads.each do |t|
                  t.join if t != Thread.current
                end
                puts 'Finished!'
              end
              EventMachine.stop
            end
          end
          @requests << [http, source]
        end

        puts 'Procesing data...'
        @num_threads.times do
          @threads << Thread.new do
            loop do
              feed, source = @feeds.pop
              if feed == :finish then
                @feeds.push :finish
                break
              end
              process_data feed, source
            end
          end
        end
      end
    end

    private
    def process_data feed, source
      feed.channel.items.each do |item|
        title = item.title.strip
        page_content = item.description
        content = page_content.gsub /<\/?[^>]*>/," "
        content.strip!
        date = item.pubDate
        link = item.link.strip
        images = Nokogiri::HTML(page_content).css('img')
        if images.length > 0 then
          image = images[0]['src']
        end

        unless Post.exists? title: title
          Post.create title: title, content: content, image: image, url: link, source_id: source.id, category_id: 1, created_at: date
          puts "POST: #{title} was created successfully"
        end
      end
    end
  end

  def self.start_wrapping
    c = Wr.new THREADS
    c.start
  end
end