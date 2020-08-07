class Invest::Scraper
  
  def get_page
    Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  end
  
  # def scrape_restaurants_index
  #   self.get_page.css("div[data-list='1-50'] a.item")
  # end
  
  
  
  #       makes restaurant objects from index
  # def make_restaurants
  #   scrape_restaurants_index.each do |r|
  #     WorldsBestRestaurants::Restaurant.new_from_index_page(r)
  #   end
  # end
  
  # def make_topics
    
  # end
  
  
  
  def scrape_dictionary_for_terms(input)
  
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
    alphabet_front = ("A".."M").to_a
    alphabet_back = ("N".."Z").to_a

    if input == "#"
      @topic_names = doc.css("div#dictionary-top24-list__sublist-content_1-0").map{|n| n.text}
      @topic_names = @topic_names[0].split("\n")
        if @topic_names.include?("")
          @topic_names.delete("")
        end
      @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_1-0 a").map{|n| n.attribute("href").value}
    elsif input != "exit"
      if alphabet_front.include?(input)
      alphabet_front.each_with_index do |letter, index|
        if input.chr == letter
          @topic_names = doc.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1}").map{|n| n.text}
          @topic_names = @topic_names[0].split("\n")
          if @topic_names.include?("")
            @topic_names.delete("")
          end
          @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1} a").map{|n| n.attribute("href").value}
        end
      end
      elsif alphabet_back.include?(input)
      alphabet_back.each_with_index do |letter, index|
        if input.chr == letter && letter == "N"
          @topic_names = doc.css("div#dictionary-top24-list__sublist-content_2-0").map{|n| n.text}
          @topic_names = @topic_names[0].split("\n")
          if @topic_names.include?("")
            @topic_names.delete("")
          end
          @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_2-0 a").map{|n| n.attribute("href").value}
        elsif input.chr == letter && letter != "N"
          @topic_names = doc.css("div#dictionary-top24-list__sublist-content_2-0-#{index}").map{|n| n.text}
          @topic_names = @topic_names[0].split("\n")
            if @topic_names.include?("")
              @topic_names.delete("")
            end
          @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_2-0-#{index} a").map{|n| n.attribute("href").value}
        end
        end  
      end
    end
      @topic_names.each_with_index do |t_name, index|
      topic = Invest::Topic.new
      topic.name = t_name
      topic.url = @topic_urls[index]
      new_doc = Nokogiri::HTML(open(topic.url))
      topic.definition = new_doc.css("p#mntl-sc-block_1-0-1").text.strip
      takeaways = new_doc.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
      topic.takeaways = takeaways.split(".")
    end
  end
  
  # Invest::Topic.all.each do |topic|
  #   opened_url = Nokogiri::HTML(open(topic.url))
  #   topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
  #   topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
  # end
end