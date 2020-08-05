class Invest::Topic
  attr_accessor :name, :definition, :takeaways, :url
  
  @@all = []
  
  def self.scrape_topics
    @topics = []
    
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  # array of all topic names, as scraped from doc (dictionary webpage)
    @topics_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.text}
  # array of all urls in the same order as @topic_array
    @url_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.attribute("href").value}
    
     @topics_array.each do |topic|
       new_topic = Invest::Topic.new
       new_topic.name = topic
       @@all << new_topic
     end
     
     @@all.each_with_index do |topic, index|
       topic.url = @url_array[index]
     end
      binding.pry
  # assign urls to topics??
      # opened_url = Nokogiri::HTML(open(new_topic.url))
      # new_topic.definition = opened_url.css("p#mntl-sc-block_1-0-1").text.strip
      # new_topic.takeaways = opened_url.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
      # binding.pry
      # @@all << new_topic
  #   end
    
  # These topics need to not be hard coded...
  # Scrape the webpage, instantiate a Topic, take data from scrape & apply to attrs
  # Each instance of topic should shovel into @@all array upon instantiation
  
    
    
  # probably cli?? not sure yet  
  # def list_by_first_letter
  #   input = gets.strip
  #   @topics_array.each do |topic|
  #     if input == topic.chr
  #       puts topic
  #     end
  #   end
  # end
    
    
    
    # name = doc.css("a#dictionary-top24-list__sublist_1-0-38 span.link__wrapper").text.strip
    # url = doc.css("a#dictionary-top24-list__sublist_1-0-38").attribute('href').value
    # doc_2 = Nokogiri::HTML(open(url))
    # takeaways = doc_2.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
    # definition = doc_2.css("p#mntl-sc-block_1-0-1").text.strip
    # topic = Invest::Topic.new
    # topic.name = name
    # topic.definition = definition
    # topic.takeaways = takeaways
    # topic.url = url
    # @topics << topic
    # binding.pry
    # @topics
  end
  
  def self.all
  # return all instances of Topic class  
  

  
    topic_1 = self.new
    topic_1.name = "Annuity"
    topic_1.definition = "Annuity Definition"
    topic_1.takeaways = "Annuity Key Takeaways"
    topic_1.url = "Anuity URL"
    
    topic_2 = self.new
    topic_2.name = "Asset Management"
    topic_2.definition = "Asset Management Definition"
    topic_2.takeaways = "Asset Management Key Takeaways"
    topic_2.url = "Asset Management URL"
    
    [topic_1, topic_2]
    
  # @@all
  end
  
end