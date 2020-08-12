class Invest::Topic
  attr_accessor :name, :url, :definition, :takeaways
    
  @@all = []
  
  def self.new_from_index_page(r)
    self.new(
        r.css("span.link__wrapper").text,     # name  
        r.attribute("href").text              # url
      )
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
  
  def self.puts_topics
    self.all.each_with_index do |topic, index|
      puts "#{index + 1}. #{topic.name}"
    end
  end
  
  def self.puts_topic_from_input(input)
    topic = self.all[input.to_i - 1]
    puts "--------#{input.to_i}. #{topic.name.upcase}---------"
    puts " "
    puts topic.definition.wrap_to_limit(60)
      if topic.takeaways == nil || topic.takeaways == []
        puts ""
      else
        puts " "
        puts "----------KEY TAKEAWAYS-----------"
        topic.takeaways.each_with_index do |t_a, i| 
          puts " "
          puts "#{i + 1}. #{t_a.wrap_to_limit(60)}"
        end
      end
    puts " "
    puts "----------------------------------------------------"  
    puts "If you would like to learn more, visit: "
    puts "#{topic.url}"
    puts "----------------------------------------------------"
  end
  
end