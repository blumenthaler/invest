class Invest::CLI
  
  def call
    puts "---------Welcome to Investment Definitions!---------"
    list_topics_by_first_letter
  end

  def list_topics_by_first_letter
    Invest::Topic.all.clear
    puts "----------------------------------------------------"
    puts "Please enter the first letter (A-Z) of the topic you wish to learn more about (or # for number):".wrap_to_limit(80)
    puts "----------------------------------------------------"
    alphabet = ("A".."Z").to_a
    input = gets.strip
    @scraper = Invest::Scraper.new
      if alphabet.include?(input) || input == "#"
        @scraper.scrape_topic_page_from_input(input)
        @scraper.make_topics
        puts "----------------FINANCIAL TERMS (#{input})-----------------"
        Invest::Topic.puts_topics
        display_definitions
      else
        puts "I am sorry, I do not understand your input, please try again."
        puts "----------------------------------------------------"
        list_topics_by_first_letter
      end
  end
  
  def display_definitions
    puts "----------------------------------------------------"
    puts "Select the number of the topic you would like to learn more about (1-#{Invest::Topic.all.size}), type topics to see the list of topics again, or type exit.".wrap_to_limit(80)
    puts "----------------------------------------------------"
    input = gets.strip
      if input.to_i > 0
        @scraper.definition(input)
        @scraper.takeaways(input)
        Invest::Topic.puts_topic_from_input(input)
        puts "Would you like to view another topic definition? (Y/N)"
        input = gets.strip
          if input == "N"
            exit_program
          elsif input == "Y"
            list_topics_by_first_letter
          end
      elsif input == "topics"
        list_topics_by_first_letter
      elsif input == "exit"
        exit_program
      else
        puts "I am sorry, I do not understand your input, please try again."
      end
  end
    
  def exit_program
    puts "----------------------------------------------------" 
    puts "Goodbye!"
    puts "----------------------------------------------------" 
  end
end