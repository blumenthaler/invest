class Invest::Scraper
  
  def self.scrape_page_for_terms(input)
    # takes in input as an argument (A-Z or #)
    # scrape investopedia for list of financial terms whose first character matches input
    
    @topics = []
    
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
    if input == "#" 
      @topic_names = doc.css("div#dictionary-top24-list__sublist-content_1-0").map{|n| n.text}
    binding.pry
      
      
      
      # && topic.name.chr.to_i > 0



#    @topics_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.text}
  # array of all urls in the same order as @topic_array
  # @url_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.attribute("href").value}
    
  # @topics_array.each do |topic|
  #   new_topic = Invest::Topic.new
  #   new_topic.name = topic
  #   Invest::Topic.all << new_topic
  end
     
  Invest::Topic.all.each_with_index do |topic, index|
    topic.url = @url_array[index]
  end
    
  Invest::Topic.all.each do |topic|
    opened_url = Nokogiri::HTML(open(topic.url))
    topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
    topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
  end
    
  end
  
  
end