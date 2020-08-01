class Invest::CLI
  
  def call
    # prints greeting
    puts "Welcome to Investment Definitions!"
    list_topics
    display_definitions
  end

  def list_topics
    # lists all topics
    puts "--------FINANCIAL TERMS:---------"
    @topics = Invest::Topic.all
    @topics.each.with_index(1) do |topic, i|
      puts "#{i}. #{topic.name}"
    end
  end
    
  def display_definitions
    input = nil
    while input != "exit"
    puts "---------------------------------"
    puts "Select the number of the topic you would like to learn more about (1-#{@topics.size}), type topics to see the list of topics again, or type exit."
    puts "---------------------------------"
    input = gets.strip.downcase
      
      if input.to_i > 0
        
        topic = @topics[input.to_i - 1]
        puts "--------#{topic.name}--------"
        puts topic.definition
        puts topic.takeaways
        puts "If you would like to learn more, visit: #{topic.url}"
        
      elsif input == "topics"
        list_topics
      elsif input == "exit"
        exit_program
      else
        puts "I am sorry, I do not understand your input, please try again."
      end
    end
  end
    
    def exit_program
      puts "Goodbye!"
    end
  
end
