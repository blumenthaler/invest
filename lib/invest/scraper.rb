class Invest::Scraper
  
  def self.scrape_dictionary_for_terms(input)
    # I need to instantiate Topics for each term that is matched--
    # as well as apply name & url attrs for each topic (upon instantiation)
  
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
    alphabet = ("A".."Z").to_a
    
    if input == "#"
      @topic_names = doc.css("div#dictionary-top24-list__sublist-content_1-0").map{|n| n.text}
      @topic_names = @topic_names[0].split("\n")
        if @topic_names.include?("")
          @topic_names.delete("")
        end
      @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_1-0 a").map{|n| n.attribute("href").value}
    elsif input != "exit"
      alphabet.each_with_index do |letter, index|
        if input.chr == letter
          @topic_names = doc.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1}").map{|n| n.text}
          @topic_names = @topic_names[0].split("\n")
          if @topic_names.include?("")
            @topic_names.delete("")
          end
          @topic_urls = doc.css("div#dictionary-top24-list__sublist-content_1-0-#{index + 1} a").map{|n| n.attribute("href").value}
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