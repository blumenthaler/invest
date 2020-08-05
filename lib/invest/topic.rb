class Invest::Topic
  attr_accessor :name, :definition, :takeaways, :url
  
  @@all = []
  
  def self.scrape_topics
    @topics = []
    
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
  # array of all topic names, as scraped from doc (dictionary webpage)
    @topics_array = doc.css("a.dictionary-top24-list__sublist.mntl-text-link").map{|n| n.text}
    
    
    name = doc.css("a#dictionary-top24-list__sublist_1-0-38 span.link__wrapper").text.strip
    url = doc.css("a#dictionary-top24-list__sublist_1-0-38").attribute('href').value
    doc_2 = Nokogiri::HTML(open(url))
    takeaways = doc_2.css("div#mntl-sc-block-callout-body_1-0 ul li").text.strip
    definition = doc_2.css("p#mntl-sc-block_1-0-1").text.strip
    topic = Invest::Topic.new
    topic.name = name
    topic.definition = definition
    topic.takeaways = takeaways
    topic.url = url
    @topics << topic
    binding.pry
    @topics
  end
  
  def self.all
  # return all instances of Topic class  
  
  # These topics need to not be hard coded...
  # Scrape the webpage, instantiate a Topic, take data from scrape & apply to attrs
  # Each instance of topic should shovel into @@all array upon instantiation
  
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