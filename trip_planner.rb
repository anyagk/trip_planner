require 'pry'
require 'httparty'
require 'cgi'
<<<<<<< HEAD
<<<<<<< HEAD
require 'json'


class TripPlanner
  attr_reader :user, :forecast, :recommendation 
  
=======
require 'pry'

class TripPlanner
  attr_reader :user, :forecast, :recommendation

>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======

class TripPlanner
  attr_reader :user, :forecast, :recommendation
  
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  def initialize
    # Should be empty, you'll create and store @user, @forecast and @recommendation elsewhere
  end
<<<<<<< HEAD

<<<<<<< HEAD
  def to_s
    "Hi, #{name}, welcome to your trip planner! On your journey to #{destination} for #{duration} day, I'd recommend you bring: #{recom}. Have fun!"
  end


  def plan
    @user = self.create_user
    @forecast = self.retrieve_forecast
    @recommendation = self.create_recommendation

    # Plan should call create_user, retrieve_forecast and create_recommendation 
    # After, you should display the recommendation, and provide an option to 
    # save it to disk.  There are two optional methods below that will keep this
    # method cleaner.
=======
  def plan
    @user = create_user

    @forecast = retrieve_forecast
    unless @forecast
      puts "City not found..."
      return nil
    end

    @recommendation = create_recommendation

    display_recommendation
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
  end

  def display_recommendation
    puts @user

    puts "You'll need the following clothes: "
    @recommendation[:clothes].each do |piece|
      puts "- #{piece}"
    end
    puts "And the following accessories: "
    @recommendation[:accessories].each do |piece|
      puts "- #{piece}"
    end
=======
  
  def plan
    # Plan should call create_user, retrieve_forecast and create_recommendation 
    # After, you should display the recommendation, and provide an option to 
    # save it to disk.  There are two optional methods below that will keep this
    # method cleaner.
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  end
  
  # def display_recommendation
  # end
  #
  # def save_recommendation
  # end
  
  def create_user
<<<<<<< HEAD
<<<<<<< HEAD
    puts "Please enter your name:"
    name = gets.chomp
    puts "Please enter the destination city (City Name, State Initials):"
    destination = gets.chomp
    puts "Please enter how long you'll be there:"
    duration = gets.chomp
    user = User.new(name, destination, duration)
    # @user1 = [name, destination, duration]
    # puts user1
    # provide the interface asking for name, destination and duration
    # then, create and store the User object
  end
  


  def retrieve_forecast
    city = @user.destination
    days = @user.duration
    units = "imperial" # you can change this to metric if you prefer
    options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
    response =  HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/#{options}")
    result = JSON.parse(response.body)
        # Pry.start(binding)
    stats_array = result["list"]

    weather_array = stats_array.map do |day|
      Weather.new(day["temp"]["min"], day["temp"]["max"], day["weather"][0]["main"])
    end
  end

  def create_recommendation
    recom = []
    @forecast.map do |days|
      recom << days.appropriate_clothing
      recom << days.appropriate_accessories
    end
  end

=======
    print "Your name > "
    name = gets.chomp

    print "Trip Destination (e.g. Binghamton, NY) > "
    destination = gets.chomp

    print "Trip Duration (in days) > "
    duration = gets.chomp.to_i

    return User.new(name, destination, duration)
=======
    # provide the interface asking for name, destination and duration
    # then, create and store the User object
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  end
  
  def retrieve_forecast
    # use HTTParty.get to get the forecast, and then turn it into an array of
    # Weather objects... you  might want to institute the two methods below
    # so this doesn't get out of hand...
  end
  
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
<<<<<<< HEAD
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
  
  # def collect_clothes
  # end
  #
  # def collect_accessories
  # end
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
end
    # once you have the forecast, ask each Weather object for the appropriate
    # clothing and accessories, store the result in @recommendation.  You might

class Weather
  attr_reader :min_temp, :max_temp, :condition
<<<<<<< HEAD
<<<<<<< HEAD
  
=======
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de

=======
  
  # given any temp, we want to search CLOTHES for the hash
  # where min_temp <= temp and temp <= max_temp... then get
  # the recommendation for that temp.
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  CLOTHES = [
    {
      min_temp: -50, max_temp: 0,
      recommendation: [
        "insulated parka", "long underwear", "fleece-lined jeans",
<<<<<<< HEAD
        "mittens", "knit hat", "chunky scarf"]
    },
    {
      min_temp: 1, max_temp: 60,
      recommendation: [
        "windbreaker", "long sleeved shirt", "jeans", "socks"]
    },
    {
      min_temp: 61, max_temp: 150,
      recommendation: [
        "tanktop", "shorts", "bathing suit", "skirt", "t shirt"]
=======
        "mittens", "knit hat", "chunky scarf"
      ]
<<<<<<< HEAD
    },
    {
      min_temp: 20, max_temp: 40,
      recommendation: [
        "down jacket", "sweater", "corduroy pants",
        "wool cap", "gloves"
      ]
    },
    {
      min_temp: 40, max_temp: 70,
      recommendation: [
        "sport coat", "cardigan", "slacks"
      ]
    },
    {
      min_temp: 70, max_temp: 120,
      recommendation: [
        "shorts", "short sleeve shirt"
      ]
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
    }
  ]


  ACCESSORIES = [
    {
<<<<<<< HEAD
      condition: "Rain",
      recommendation: [
<<<<<<< HEAD
      "galoshes", "umbrella"]
    },
    {
      condition: "Clear",
      recommendation: [
        "sunglasses", "flipflops", "handfan"]
    },
    {
      condition: "Snow",
      recommendation: [
        "snow boots", "goggles", "crampons", "ski poles"]
=======
        "galoshes", "umbrella"
      ]
    },
    {
      condition: "Clouds",
      recommendation: [
        "galoshes", "umbrella"
      ]
    },
    {
      condition: "Clear",
      recommendation: [
        "sun glasses", "visor"
      ]
    },
    {
      condition: "Snow",
      recommendation: [
        "chunky scarf", "knit hat"
      ]
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
      condition: "Rainy",
      recommendation: [
        "galoshes", "umbrella"
      ]
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
    }
  ]
  
  def initialize(min_temp, max_temp, condition)
<<<<<<< HEAD
    @min_temp = min_temp
    @max_temp = max_temp
    @condition = condition
<<<<<<< HEAD
  end

  def to_s
    puts "the high is #{max_temp}, the low is #{min_temp} and the description is #{condition}"

  end

  def self.clothing_for(temp)
    if temp >= CLOTHES[0][:min_temp] && temp <= CLOTHES[0][:max_temp]
      return CLOTHES[0][:recommendation]
    elsif temp >= CLOTHES[1][:min_temp] && temp <= CLOTHES[1][:max_temp]
      return CLOTHES[1][:recommendation]
    elsif temp > CLOTHES[2][:min_temp] && temp <= CLOTHES[2][:max_temp]
      return CLOTHES[2][:recommendation]
    end
  end
    # This is a class method, have it find the hash in CLOTHES so that the 
    # input temp is between min_temp and max_temp, and then return the 
    # recommendation.
  def self.accessories_for(condition)
    if condition == ACCESSORIES[0][:condition]
      return ACCESSORIES[0][:recommendation]
    elsif condition == ACCESSORIES[1][:condition]
      return ACCESSORIES[1][:recommendation]
    elsif condition == ACCESSORIES[2][:condition]
      return ACCESSORIES[2][:recommendation]
    end 
    # This is a class method, have it find the hash in ACCESSORIES so that
    # the condition matches the input condition, and then return the
    # recommendation.
  end
  

  def appropriate_clothing
    clothing_array = []
    clothing_array << Weather.clothing_for(@min_temp)
    clothing_array << Weather.clothing_for(@max_temp)
    puts clothing_array.uniq
  end

  def appropriate_accessories
    accessories_array = []
    accessories_array << Weather.accessories_for(@condition)
    puts accessories_array.uniq
=======
  end

  def to_s
    "#{@condition}, temperature between #{@min_temp} and #{@max_temp}."
=======
    
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
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
<<<<<<< HEAD
    Weather.accessories_for(@condition)
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
    # Use the results of Weather.accessories_for(@condition) to make
    # an array of appropriate accessories for the weather object.
    # You should avoid making the same suggestion twice... think
    # about using .uniq here
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  end

end

class User
  attr_reader :name, :destination, :duration
  
  def initialize(name, destination, duration)
<<<<<<< HEAD
    @name = name
    @destination = destination
<<<<<<< HEAD
    @duration = duration    
=======
    @duration = duration
  end

  def to_s
    "#{@name}, you are going to #{@destination} for #{@duration} days."
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
    
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
  end
end

trip_planner = TripPlanner.new
<<<<<<< HEAD
trip_planner.plan
<<<<<<< HEAD

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
    # puts"_________________"


    #   @date = stats_array["dt"]
    #   @min_temp = stats_array["temp"]["min"]
    #   @max_temp = stats_array["temp"]["max"]
    #   @main = stats_array["weather"]["main"]
    

    # retrieved = user.call_api
    # retrieved.parse_result
    # units = "imperial" # you can change this to metric if you prefer
    # options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
    # use HTTParty.get to get the forecast, and then turn it into an array of
    # Weather objects... you  might want to institute the two methods below
    # so this doesn't get out of hand...


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
=======
>>>>>>> 204aa03a8d2311cda12f5101b5b5f496d71582de
=======
trip_planner.start
>>>>>>> af4c43786b24e1f6cb26834c0b74cd26e663ac47
