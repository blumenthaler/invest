class Invest::Scraper
  
  def scrape_dictionary_for_terms(input)
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
    end
  end
    
      # if doc.css("a span.link__wrapper").text == topic.name
      #   
# && topic.name.chr.to_i > 0

#    @topics_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.text}
  # array of all urls in the same order as @topic_array
  # @url_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.attribute("href").value}

     
  # Invest::Topic.all.each_with_index do |topic, index|
  #   topic.url = @url_array[index]
  # end
    
  # Invest::Topic.all.each do |topic|
  #   opened_url = Nokogiri::HTML(open(topic.url))
  #   topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
  #   topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
  # end
end