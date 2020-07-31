class Invest::CLI
  
  def call
    # prints greeting
    puts "Welcome to Investing Definitions!"
    list_topics
  end

  def list_topics
    # lists all topics
    puts "----------FINANCIAL TERMS:----------"
    puts "1. Annuity"
    puts "2. Asset Management"
    display_definitions
  end
    
  def display_definitions
    puts "Please select a topic you would like to learn more about:"
    input = gets.strip.downcase
    if input == "1"
      puts "----------Annuity----------"
      puts "An annuity is a financial product that pays out a fixed stream of payments to an individual, and these financial products are primarily used as an income stream for retirees. Annuities are contracts issued and distributed (or sold) by financial institutions, which invest funds from individuals. They help individuals address the risk or outliving their savings. Upon annuitization, the holding institution will issue a stream of payments at a later point in time."
      puts "----------KEY TAKEAWAYS:----------"
      puts "1. Annuities are financial products that offer a guaranteed income stream, used primarily by retirees."
      puts "2. Annuities exist first in an accumulation phase, whereby investors fund the product with either a lump-sum or periodic payments."
      puts "3. Once the annuitization phase has been reached, the product begins paying out to the annuitant for either a fixed period or for the annuitant's remaining lifetime."
      puts "4. Annuities can be structured into different kinds of instruments - fixed, variable, immediate, deferred income, that give investors flexibility."
      puts "To learn more about Annuity, visit: https://www.investopedia.com/terms/a/annuity.asp"
      list_topics
    elsif input == "2"
      puts "----------Asset Management----------"
      puts "Asset management is the direction of all or part of a client's portfolio by a financial services institution, usually an investment bank, or an individual. Institutions offer investment services along with a wide range of traditional and alternative product offerings that might not be available to the average investor."
      puts "----------KEY TAKEAWAYS:----------"
      puts "1. Asset management refers to the management of investments on behalf of others."
      puts "2. The goal is to grow a client's portfolio over time while mitigating risk."
      puts "3. Asset management is a service offered by financial institutions catering to high net-worth individuals, government entities, corporations and financial intermediaries."
      puts "To learn more about Asset Management, visit: https://www.investopedia.com/terms/a/assetmanagement.asp"
     list_topics
    elsif input == "exit"
      exit_program
    else
        puts "I’m sorry, I do not understand your input."
        list_topics
    end
  end
    
    def exit_program
      puts "Goodbye!"
    end
  
end
