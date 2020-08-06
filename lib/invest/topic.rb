class Invest::Topic
  attr_accessor :name, :definition, :takeaways, :url
  
  def initialize(name = nil, definition = nil, takeaways = nil, url = nil)
    @@all << self
  end
  
  @@all = []
  
  def self.all
    @@all
  end
  
end