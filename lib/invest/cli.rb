class Invest::CLI
  
  def call
 #   Invest::Scraper.new.make_topics
    puts "---------Welcome to Investment Definitions!---------"
    list_topics_by_first_letter
    display_definitions
  end

  def list_topics_by_first_letter
    puts "Please enter the first letter (A-Z) of the topic you wish to learn more about (or # for number):"
    puts "----------------------------------------------------"
    alphabet = ("A".."Z").to_a
    input = gets.strip
    @scraper = Invest::Scraper.new
      if input == "exit"
        exit_program
      elsif alphabet.include?(input) || input == "#"
        @scraper.scrape_topic_page_from_input(input)
        @scraper.make_topics
        puts "----------------FINANCIAL TERMS (#{input})-----------------"
          Invest::Topic.all.each_with_index do |topic, index|
          puts "#{index + 1}. #{topic.name}"
          end
      else
        puts "I am sorry, I do not understand your input, please try again."
        list_topics_by_first_letter
      end
  end
  
  def display_definitions
    input = nil
    while input != "exit"
    puts "Select the number of the topic you would like to learn more about (1-#{Invest::Topic.all.size}), type topics to see the list of topics again, or type exit."
    puts "----------------------------------------------------"
    input = gets.strip.downcase
      if input.to_i > 0
        @scraper.definition(input)
        @scraper.takeaways(input)
        topic = Invest::Topic.all[input.to_i - 1]
        puts "--------#{input.to_i}. #{topic.name}---------"
        puts " "
        puts topic.definition
        if topic.takeaways == nil || topic.takeaways == []
          puts " "
        else
          puts " "
          puts "----------KEY TAKEAWAYS-----------"
          topic.takeaways.each_with_index do |t_a, i| 
            puts " "
            puts "#{i + 1}. #{t_a}"
          end
        end
        puts " "
        puts "----------------------------------------------------"  
        puts "If you would like to learn more, visit: #{topic.url}"
        puts "----------------------------------------------------"
      elsif input == "topics"
        Invest::Topic.all.clear
        list_topics_by_first_letter
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