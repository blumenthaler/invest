class Invest::Topic
  attr_accessor :name, :url, :definition, :takeaways
    
  @@all = []
  
  def self.new_from_index_page(r)
    self.new(
        r.css("span.link__wrapper").text,     # name  
        r.attribute("href").text              # url
      )
      binding.pry
  end
  
  def initialize(name = nil, url = nil, definition = nil, takeaways = nil)
    @name = name
    @definition = definition
    @url = url
    @takeaways = takeaways
    @@all << self
  end
  
  def self.all
    @@all
  end
  
end