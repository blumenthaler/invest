class Invest::Topic
  attr_accessor :name, :definition, :takeaways, :url
  
  @@all = []
  
  def self.scrape_topics
    topics = []
    
    doc = Nokogiri::HTML(open("https://www.investopedia.com/financial-term-dictionary-4769738"))
    binding.pry
    topics
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