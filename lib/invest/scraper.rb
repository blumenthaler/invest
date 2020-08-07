class Invest::Scraper
  
  def self.get_page
    Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  end
  
# I do not want to scrape hundreds of topic pages at once
# so Scraper.scrape_topic_page_from_input will scrape based on input (by first character)
# that method will return an array of nokogiri'd html of pages for topics with the same first letter
# Scraper.make_topics will use that array to create topic class instances

  @@topic_indexes = []
  
  def self.scrape_topic_page_from_input(input)
    alphabet_front = ("A".."M").to_a
    alphabet_back = ("N".."Z").to_a
    @@topic_indexes = []
    
    if input == "#"
      @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_1-0 a.dictionary-top24-list__sublist.mntl-text-link")
    elsif input != "exit"
      if alphabet_front.include?(input)
        alphabet_front.each_with_index do |letter, index|
          if input.chr == letter
            # make sure all of these are the nokogiri'd html of each index page
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1} a.dictionary-top24-list__sublist.mntl-text-link")
          end
        end
      elsif alphabet_back.include?(input)
        alphabet_back.each_with_index do |letter, index|
          if input.chr == letter && letter == "N"
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_2-0 a.dictionary-top24-list__sublist.mntl-text-link")
          elsif input.chr == letter && letter != "N"
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_2-0-#{index} a.dictionary-top24-list__sublist.mntl-text-link")
          end
        end  
      end
    end
  return @@topic_indexes
    binding.pry
  end

# makes topic object instances from index
  def self.make_topics
    @@topic_indexes.each do |r|
      Invest::Topic.new_from_index_page(r)
    end
  end

#       @topic_names.each_with_index do |t_name, index|
#       topic = Invest::Topic.new
#       topic.name = t_name
#       topic.url = @topic_urls[index]
#       new_doc = Nokogiri::HTML(open(topic.url))
#       topic.definition = new_doc.css("p#mntl-sc-block_1-0-1").text.strip
#       takeaways = new_doc.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
#       topic.takeaways = takeaways.split(".")
#     end
#   end
  
#   # Invest::Topic.all.each do |topic|
#   #   opened_url = Nokogiri::HTML(open(topic.url))
#   #   topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
#   #   topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
#   # end
 end