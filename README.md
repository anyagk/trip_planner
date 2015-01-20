

# TripPlanner

We are going on a trip later today, and we want to create an application that will help us pack our bags based on the weather at our destination.  

As a user I want to:
  - Tell the app where I'm going
    - e.g. 'London, UK', 'Honolulu, HI', 'Dalton, GA'
  - Tell the app how many days I'll be gone for.
  - Have the app tell me the overall forecast for those days.
    - e.g. "January 18th will be sunny, with a low of 45 and a high of 72."
  - Have the app tell me what clothing to pack for the trip, both based on temperature as well as weather conditions
    - e.g. "You should bring shorts, a windbreaker, and a visor."
  - Have the app write to a file so I can retrieve the results later.

# OpenWeatherMap API

We're going to get daily weather data for a location. Suppose the user has already supplied us with `city` and `days`.

```ruby
  units = "imperial" # you can change this to metric if you prefer
  options = "daily?q=#{CGI::escape(city)}&mode=json&units=#{units}&cnt=#{days}"
  url = "http://api.openweathermap.org/data/2.5/forecast/#{options}"
```

Remember we need to escape the city since spaces and certain characters in a url can cause errors.

# Part I - `TripPlanner`

Let's create the class that will be our main object.  Once we're ready to start the program, we'll simply run the following code, and bask in the glory of our efforts.

```ruby
  trip_planner = TripPlanner.new
  trip_planner.start
```

This means that `TripPlanner` will have the following attributes and methods:

## Attributes
`TripPlanner` will need to keep track of a `user`, the `forecast`, and the `recommendation`.  These attributes should be read only, there's no reason for the main program flow to have to change them directly.

## Methods

### `TripPlanner#initialize`
Our initialize will be funny, in that it won't do anything, or take any parameters.

### `TripPlanner#plan`
plan is where the action happens.  Plan, as a method, should do these things:
  - Assign the result of `.create_user` to `@user`
  - Assign the result of `.retrieve_forecast` to `@forecast`
  - Assign the result of `.create_recommendation` to `@recommendation`
  - Report the forecast and recommendation, and save it to a file

### `TripPlanner#create_user`
As the method name suggests, it should ask the person at the keyboard for their name, destination city, and duration of the trip.  It will then call `User.new`, passing along that information, and storing it in `@user`.

### `TripPlanner#retrieve_forecast`
This method will make the actual call to the API, and do the parsing of the data the API returns.  

It should strip only the information useful to create `Weather` objects, described below, and then create and store the array of weather objects in `@forecast`

**Hint:** It might help to have some additional helper methods to keep `.retrieve_forecast` slim.  I would suggest having `call_api` and `parse_result` methods.

### `TripPlanner#create_recommendation`
This method will take the `@forecast` array, and create the actual recommendation for your trip.  

**Hint:** Again, I would create a few helper methods to implement this.  Perhaps: `collect_clothes`, `collect_accessories`, `display_recommendation`, `save_recommendation`.

# Part 2 - `Weather`

Since the `TripPlanner` will store the forecast as an array of `Weather` objects, I suppose we should have a `Weather` Class.

The weather object will be responsible for suggesting clothing and accessories based on the `min_temp`, `max_temp`, and `condition`

## Attributes

We're only going to care about `min_temp`, `max_temp`, and `condition` when it comes to making decisions about the day.  Again, we won't need to change these during the course of the program, so just make them readable.

We'll also do something **totally new**: the `Weather` class will be much more usable if we create two separate class constants: `CLOTHES` and `ACCESSORIES`.  Here's something to get you started:  

```ruby
class Weather
  CLOTHES = [
    {
      min_temp: -50, max_temp: 0,
      suggestions: [
        "insulated parka", "long underwear", "fleece-lined jeans",
        "mittens", "knit hat", "chunky scarf"
      ]
    }
  ]

  ACCESSORIES = [
    {
      condition: "Rainy",
      suggestions: [
        "galoshes", "umbrella"
      ]
    }
  ]
end
```

These are arrays of hashes, where the first one allows us to search by range and the second by condition.  

For methods inside the class, you can just access these constants as written: `ACCESSORIES[0][:condition]` or `CLOTHES[0][:suggestions]`, etc.

## Methods

### `Weather#appropriate_clothing`
Appropriate clothing depends on what temperatures you'll have to endure for the day.  This method should utilize the class method `Weather::clothing_for` to grab the clothing for the max and min temps, and return those results as an array of suggestions without repeat.

### `Weather#appropriate_accessories`
Appropriate accessories depend on what conditions you'll face that day.  This method should utilize the class method `Weather::accessories_for` to grab the accessories for the condition, and return those results as an array of suggestions without repeat.

## Class Methods

To make the previous two methods easier to implement, let's create two class level methods to do the actual lookup with our constants:

### `Weather::clothing_for`
This class should actually do the heavy lifting for `Weather#appropriate_clothing`.  It should `select` and `map` from the `CLOTHES` array the suggestions appropriate for `condition`.

### `Weather::accessories_for`
This class should actually do the heavy lifting for `Weather#appropriate_accessories`.  It should `select` and `map` from the `ACCESSORIES` array the suggestions appropriate for `condition`.

# Part C - `User`

## Attributes
Here we want to store (and leave alone) their `name`, and the `destination` and `duration` for their trip.
