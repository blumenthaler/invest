class Invest::CLI
  
  def call
    # prints greeting
    puts "Welcome to Investment Definitions!"
    list_topics_by_first_letter
    # display_definitions
  end

  def self.list_topics_by_first_letter
      
    # list topics by first letter upon user input:
      # ask for input: first letter of topic or # for number
      # list topics withg matching first letter (or all that start with a number)
    puts "Please enter the first letter (A-Z) of the topic you wish to learn more about (or # for number):"
    input = gets.strip
    Invest::Topic.scrape_topics
      Invest::Topic.all.each do |topic|
        if input == "#" && topic.name.chr.to_i > 0
          puts topic.name
        elsif input == topic.name.chr
          puts topic.name
        end
      end
    # puts "--------FINANCIAL TERMS:---------"
    # @topics = Invest::Topic.all
    # @topics.each.with_index(1) do |topic, i|
    #   puts "#{i}. #{topic.name}"
    # end
  end
    
  # def display_definitions
  #   input = nil
  #   while input != "exit"
  #   puts "---------------------------------"
  #   puts "Select the number of the topic you would like to learn more about (1-#{@topics.size}), type topics to see the list of topics again, or type exit."
  #   puts "---------------------------------"
  #   input = gets.strip.downcase
      
  #     if input.to_i > 0
        
  #       topic = @topics[input.to_i - 1]
  #       puts "--------#{topic.name}--------"
  #       puts topic.definition
  #       puts topic.takeaways
  #       puts "If you would like to learn more, visit: #{topic.url}"
        
  #     elsif input == "topics"
  #       list_topics
  #     elsif input == "exit"
  #       exit_program
  #     else
  #       puts "I am sorry, I do not understand your input, please try again."
  #     end
  #   end
  # end
    
  def exit_program
    puts "Goodbye!"
  end
end