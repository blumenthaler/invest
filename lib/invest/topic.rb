class Invest::Topic
  attr_accessor :name, :definition, :url
    
  @@all = []
  
  def self.new_from_index_page(r)
    self.new(
        r.css("span.link__wrapper").text,     # name  
        Nokogiri::HTML(open(r.attribute("href").text)).css("p#mntl-sc-block_1-0-1").text.delete("\n")  ,  # definition
        r.attribute("href").text              # url
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