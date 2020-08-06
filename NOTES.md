Building Investing Definitions (yay!)


Greet user, thanks for using the app
List Topics

[list of topics (theres just too many!)]

Which topic would you like to learn more about?

User inputs which topic definition they want to see

Display topic definition, key takeaways, and site URL ("To learn more, visit:")
Ask user to input "list" to list the topics again or "exit" to exit application


Topics:
Topic has a name
Topic has a definition
Topic has a list of Key Takeaways(could this be attributed together with defintion?)
Topic has a URL

SCRAPER needs to be more efficient:
 It scrapes all the topics at once, which takes far too long
 So, we need it to scrape when needed
 We ask user for the first letter of the topic they wish to see
 So, we need to scrape the page for those topics upon request
    1. We prompt user for first letter of the topic (or # for number)
    2. user inputs # or A-Z
    3. We TAKE the input and SCRAPE ONLY those topics that start with that character
    4. We puts the resulting list to the user & ask for which one they want to see
    5. user inputs name of topic they wish to see
    6. we scrape THAT INDIVIDUAL PAGE UPON REQUEST to show the topic definition and key takeaways (if applicable)
    7. Repeat this loop, or exit
