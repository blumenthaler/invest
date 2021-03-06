class Invest::Scraper
  
  def get_page
    Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  end
  
  def scrape_topic_page_from_input(input)
    alphabet_front = ("A".."M").to_a
    alphabet_back = ("N".."Z").to_a
    @@topic_indexes = []
    
    if input == "#"
      @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_1-0 a.dictionary-top24-list__sublist.mntl-text-link")
    elsif input != "#"
      if alphabet_front.include?(input)
        alphabet_front.each_with_index do |letter, index|
          if input == letter
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1} a.dictionary-top24-list__sublist.mntl-text-link")
          end
        end
      elsif alphabet_back.include?(input)
        alphabet_back.each_with_index do |letter, index|
          if input == letter && letter == "N"
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_2-0 a.dictionary-top24-list__sublist.mntl-text-link")
          elsif input == letter && letter != "N"
            @@topic_indexes = self.get_page.css("div#dictionary-top24-list__sublist-content_2-0-#{index} a.dictionary-top24-list__sublist.mntl-text-link")
          end
        end  
      end
    end
  return @@topic_indexes
  end
  
  def make_topics
    @@topic_indexes.each do |r|
      Invest::Topic.new_from_index_page(r)
    end
  end

  def scrape_details(input)
    topic = Invest::Topic.all[input.to_i - 1]
    topic.takeaways = Nokogiri::HTML(open(topic.url)).css("div#mntl-sc-block-callout-body_1-0 ul li").map{|n| n.text}
    topic.definition = Nokogiri::HTML(open(topic.url)).css("p#mntl-sc-block_1-0-1").text.delete("\n")
  end
  
 end