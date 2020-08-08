class Invest::Scraper
  
  def self.get_page
    Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  end

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
  
  
 end