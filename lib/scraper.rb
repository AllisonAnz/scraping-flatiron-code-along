require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper

  #get_page instance method will be responsible for using Nokogiri and open-uri
  # to grab the entire HTML document from the webpage
  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
    #We know how to grab an array like collection of course elements and what code will grab the title, schedule and description of an individual memeber of that collection
    #We can iterate over the collection, make a new Course instance for each course offering element we are iterating over
    #   and assign that instance the scrape title, schedule and description
    # doc.css(".post").each do |post|
      # course = Course.new
      # course.title = post.css("h2").text
      # course.schedule = post.css(".date").text
      # course.description = post.css("p").text
      # end
    
      #above: for each iteration of the collection of Nokogiri XML elements returned to us by doc.css(".post") line
      # we are making a new instance of the Course class and
      # giving that instance the title, schedule and description extracted from the XML
  end
    
  #get_courses instance method will be responsible for using a 
  # CSS selector to grab all of the HTML elements(which is the return value of the .get_page method) that contain a course
  #   in other words, the return value of this method should be a
  #   collection of Nokogiri XML elements, that describes a course offering
  #   We're going to have to examine the page with the element inspector to find the CSS selector that contains the courses
  # So we'll call our .get_page method inside the .get_courses method
  def get_courses
    self.get_page.css(".post")
  end

  #make_courses method will be responsible for actually instantiting Course objects
  # and giving each course object the correct title, schedule and description attr. that we scraped from the page
  # should operate on the collection of course offering Nokogiri that was returned by the .get_courses method
  # .make_courses should iterate over the collection and make a new instance of Course class for each one while assigning it the appropriate attr.
  def make_courses
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end
  #print_courses method(made for you)
  #calls on .make_courses and then iterates over all the courses that get created to
  #puts out a list of course offerings
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  
end

Scraper.new.print_courses


# The collection of course offerings:
#   doc.css(".post")
# The title of an individual course offering:
#   doc.css(".post").first.css("h2").text
# The schedule of an individual course offering:
#   doc.css(".post").first.css(".date").text
# The descriptiong of an individual course offering:
#   doc.css(".post").first.css("p").text
