require 'pry'
require 'httparty'
require 'cgi'
require 'json'
require 'date'

class TripPlanner
  attr_reader :user, :forecast, :recommendation 
  attr_accessor :user1
  
  def initialize
    # Should be empty, you'll create and store @user, @forecast and @recommendation elsewhere
  end

  def plan
    @user = self.create_user
    @forecast = self.retrieve_forecast
    @recommendation = self.create_recommendation
    # Plan should call create_user, retrieve_forecast and create_recommendation 
    # After, you should display the recommendation, and provide an option to 
    # save it to disk.  There are two optional methods below that will keep this
    # method cleaner.
  end
  
  # def display_recommendation
  # end
  #
  # def save_recommendation
  # end
  
  def create_user
    puts "Please enter your name:"
    name = gets.chomp
    puts "Please enter the destination city (City Name, State Initials):"
    destination = gets.chomp
    puts "Please enter how long you'll be there:"
    duration = gets.chomp
    user = User.new(name, destination, duration)
    @user1 = [name, destination, duration]
    puts user1
    # provide the interface asking for name, destination and duration
    # then, create and store the User object
  end
  
  def retrieve_forecast
    city = @user1[1]
    days = @user1[2]
    units = "imperial" # you can change this to metric if you prefer
    options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
    response =  HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/#{options}")
    result = JSON.parse(response.body)
    # Pry.start(binding)
    stats_array = result["list"]

    dt_array = stats_array.map do |day|
     day.map do |title, stats|
       if title == "dt"
         stats
       end
     end
   end
   
   

    # day_array = []
    # day_array = stats_array.map do |day|
    #   day.map do |title, stats|
    #     if title == "dt"
    #       stats
    #     elsif title == "temp"
    #       stats["min"]
    #     elsif title == "weather"
    #       stats["main"]
    #     elsif title == "pressure"
    #       day["temp"]["max"]

    #     end 
    #   end
    # end

      

      @date = stats_array["dt"]
      @min_temp = stats_array["temp"]["min"]
      @max_temp = stats_array["temp"]["max"]
      @main = stats_array["weather"]["main"]
    

    # retrieved = user.call_api
    # retrieved.parse_result
    # units = "imperial" # you can change this to metric if you prefer
    # options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
    # use HTTParty.get to get the forecast, and then turn it into an array of
    # Weather objects... you  might want to institute the two methods below
    # so this doesn't get out of hand...
  end
  
  # def call_api
  #   city = user[1]
  #   days = user[2]
  #   units = "imperial" # you can change this to metric if you prefer
  #   options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
  #   response =  HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/#{options}")
  # end
  # def parse_result
  #   result = JSON.parse(response.body)
  # end
  # def call_api
  # end
  #
  # def parse_result
  # end
  
  def create_recommendation
    # once you have the forecast, ask each Weather object for the appropriate
    # clothing and accessories, store the result in @recommendation.  You might
    # want to implement the two methods below to help you kee this method
    # smaller...
  end
  
  # def collect_clothes
  # end
  #
  # def collect_accessories
  # end
end

class Weather
  attr_reader :min_temp, :max_temp, :condition
  
  # given any temp, we want to search CLOTHES for the hash
  # where min_temp <= temp and temp <= max_temp... then get
  # the recommendation for that temp.
  CLOTHES = [
    {
      min_temp: -50, max_temp: 0,
      recommendation: [
        "insulated parka", "long underwear", "fleece-lined jeans",
        "mittens", "knit hat", "chunky scarf"
      ]
    }
  ]

  ACCESSORIES = [
    {
      condition: "Rainy",
      recommendation: [
        "galoshes", "umbrella"
      ]
    }
  ]
  
  def initialize(min_temp, max_temp, condition)
    
  end
  
  def self.clothing_for(temp)
    # This is a class method, have it find the hash in CLOTHES so that the 
    # input temp is between min_temp and max_temp, and then return the 
    # recommendation.
  end
  
  def self.accessories_for(condition)
    # This is a class method, have it find the hash in ACCESSORIES so that
    # the condition matches the input condition, and then return the
    # recommendation.
  end
  
  def appropriate_clothing
    # Use the results of Weather.clothing_for(@min_temp) and 
    # Weather.clothing_for(@max_temp) to make an array of appropriate
    # clothing for the weather object.
    # You should avoid making the same suggestion twice... think
    # about using .uniq here
  end
  
  def appropriate_accessories
    # Use the results of Weather.accessories_for(@condition) to make
    # an array of appropriate accessories for the weather object.
    # You should avoid making the same suggestion twice... think
    # about using .uniq here
  end
end

class User
  attr_reader :name, :destination, :duration
  
  def initialize(name, destination, duration)
    @name = name
    @destination = destination
    @duration = duration    
  end
end

trip_planner = TripPlanner.new
trip_planner.plan
