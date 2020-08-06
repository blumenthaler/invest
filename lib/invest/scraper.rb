class Invest::Scraper
  
  def self.scrape_page_for_terms
    # scrape investopedia for list of financial terms
    # collect them into an array
    
    @topics = []
    
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  # array of all topic names, as scraped from doc (dictionary webpage)
    @topics_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.text}
  # array of all urls in the same order as @topic_array
  # @url_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.attribute("href").value}
    
  @topics_array.each do |topic|
    new_topic = Invest::Topic.new
    new_topic.name = topic
    Invest::Topic.all << new_topic
  end
     
  @@all.each_with_index do |topic, index|
    topic.url = @url_array[index]
  end
    
  @@all.each do |topic|
    opened_url = Nokogiri::HTML(open(topic.url))
    topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
    topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
  end
    
  end
  
  
end