class Invest::CLI
  
  def call
    # prints greeting
    puts "Welcome to Investment Definitions!"
    list_topics_by_first_letter
    display_definitions
  end

  def list_topics_by_first_letter
    puts "Please enter the first letter (A-Z) of the topic you wish to learn more about (or # for number):"
    alphabet = ("A".."Z").to_a
    input = gets.strip
    scraper = Invest::Scraper.new
      if input == "exit"
        exit_program
      elsif alphabet.include?(input) || input == "#"
        scraper.scrape_dictionary_for_terms(input)
        puts "----------FINANCIAL TERMS (#{input})----------"
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
    puts "---------------------------------"
    puts "Select the number of the topic you would like to learn more about (1-#{Invest::Topic.all.size}), type topics to see the list of topics again, or type exit."
    puts "---------------------------------"
    input = gets.strip.downcase
      if input.to_i > 0
        topic = Invest::Topic.all[input.to_i - 1]
        puts "--------#{input.to_i}. #{topic.name}---------"
        puts topic.definition
        if topic.takeaways != nil && topic.takeaways != ""
          puts "--------KEY TAKEAWAYS---------"
          topic.takeaways.each_with_index do |takeaway, index|
          puts "#{index + 1}. #{takeaway}"
          puts "--------------------------------"
          end
        end
        puts "If you would like to learn more, visit: #{topic.url}"
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
    
 # We TAKE the input and SCRAPE Dictionary page, collect those topics that start with that character
   # here, we should add the name & url attrs
   # that way, we can match the upcoming input, and then scrape the individual page

        # Invest::Topic.scrape_topics
    #   Invest::Topic.all.each do |topic|
    #     if input == "#" && topic.name.chr.to_i > 0
    #       puts topic.name
    #     elsif input == topic.name.chr
    #       puts topic.name
    #     end
      

    

    
  def exit_program
    puts "Goodbye!"
  end
end