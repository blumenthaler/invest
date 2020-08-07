class Invest::Topic
  attr_accessor :name, :definition, :takeaways, :url
    
  @@all = []
  
  def self.new_from_index_page(r)
    self.new(
      # name css selector:    r.css("name selector").text.strip     ,    
        r.css("span.link__wrapper").text,      
      # takeaways css selector: r.css("takeaways selector").text.strip ,       
        r.attribute("href").text
      )
      binding.pry
  end
  
  def initialize(name = nil, definition = nil, takeaways = nil, url = nil)
    @name = name
    @definition = definition
    @takeaways = takeaways
    @url = url
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end