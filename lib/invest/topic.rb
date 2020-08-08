class Invest::Topic
  attr_accessor :name, :definition, :url
    
  @@all = []
  
  def self.new_from_index_page(r)
    self.new(
      # name css selector:    r.css("name selector").text.strip     ,    
        r.css("span.link__wrapper").text,      
        r.attribute("href").text
      )
      binding.pry
  end
  
  def initialize(name = nil, definition = nil, url = nil)
    @name = name
    @definition = definition
    @url = url
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end