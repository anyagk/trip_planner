require 'httparty'
require 'cgi'
require 'pry'

class TripPlanner
  attr_reader :user, :forecast, :recommendation

  def initialize

  end

  def plan
    @user = create_user
    @forecast = retrieve_forecast
    @recommendation = create_recommendation

    Pry.start(binding)
  end

  # def display_recommendation
  # end
  #
  # def save_recommendation
  # end

  def create_user
    print "Your name > "
    name = gets.chomp

    print "Trip Destination (e.g. Binghamton, NY) > "
    destination = gets.chomp

    print "Trip Duration (in days) > "
    duration = gets.chomp.to_i

    return User.new(name, destination, duration)
  end

  def retrieve_forecast
    return parse_result(call_api)
  end

  def call_api
    options = "?q=#{CGI::escape(@user.destination)}&" +
              "mode=json&" +
              "units=imperial&" +
              "cnt=#{@user.duration}"

    url = "http://api.openweathermap.org/" +
          "data/2.5/forecast/daily#{options}"

    return HTTParty.get(url)
  end

  def parse_result(result)
    stripped_results = result["list"].map do |day|
      {
        min_temp:  day["temp"]["min"],
        max_temp:  day["temp"]["max"],
        condition: day["weather"][0]["main"]
      }
    end

    weather_array = stripped_results.map do |info|
      Weather.new(info[:min_temp], info[:max_temp], info[:condition])
    end
  end

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
    @min_temp = min_temp
    @max_temp = max_temp
    @condition = condition
  end

  def to_s
    "#{@condition}, temperature between #{@min_temp} and #{@max_temp}."
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

  def to_s
    "#{@name}, you are going to #{@destination} for #{@duration} days."
  end
end

trip_planner = TripPlanner.new
trip_planner.plan
