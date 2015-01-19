require 'pry'
require 'httparty'
require 'cgi'
require 'json'


class TripPlanner
  attr_reader :user, :forecast, :recommendation 
  
  def initialize
    # Should be empty, you'll create and store @user, @forecast and @recommendation elsewhere
  end

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

end
    # once you have the forecast, ask each Weather object for the appropriate
    # clothing and accessories, store the result in @recommendation.  You might

class Weather
  attr_reader :min_temp, :max_temp, :condition
  

  CLOTHES = [
    {
      min_temp: -50, max_temp: 0,
      recommendation: [
        "insulated parka", "long underwear", "fleece-lined jeans",
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
    }
  ]


  ACCESSORIES = [
    {
      condition: "Rain",
      recommendation: [
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
    }
  ]

  def initialize(min_temp, max_temp, condition)
    @min_temp = min_temp
    @max_temp = max_temp
    @condition = condition
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
    accessories_array << Weather.accessories_for(@min_temp)
    accessories_array << Weather.accessories_for(@max_temp)
    puts accessories_array.uniq
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
