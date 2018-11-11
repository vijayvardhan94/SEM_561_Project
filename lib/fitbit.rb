require "fitgem_oauth2"
require 'yaml'
require 'json'
require 'active_support/all'

class Fitbit

  attr_reader :client, :options, :config

  def initialize(options = {})
    #console.log("Fitbit has started!")
    options[:date_format] ||= "%H:%M"
    @options = options
    @config  = YAML.load(File.open(".fitbit.yml"))
    @client  = FitgemOauth2::Client.new config[:oauth].merge!(options)
    puts Dashing.config.engine_path
    puts Dashing.config.redis_namespace
  end

  def device
    if current_device != nil
    {
      
        version:   [ current_device["deviceVersion"], current_device["type"] ].join(" "),
        battery:   current_device["battery"],
        last_sync: DateTime.iso8601(current_device["lastSyncTime"]).strftime(options[:date_format])
      
    }
    end
  end

  def steps
    steps = {
      today: summary["steps"],
      total: total["steps"],
      goal:  percentage(summary["steps"].to_i, goals["steps"].to_i)
    }
    steps.merge meter: meter(steps[:goal]), intensity_class: intensity_class(steps[:goal])
  end

  def calories
    calories = {
      today: summary["caloriesOut"],
      goal:  percentage(summary["caloriesOut"], goals["caloriesOut"])
    }
    calories.merge meter: meter(calories[:goal]), intensity_class: intensity_class(calories[:goal])
  end

  def distance
    print goals['distance']
    distance = {
      today: distance_today,
      goal:  percentage(distance_today.to_f, correct_distance(goals["distance"]).to_f).to_i,
      total: correct_distance(total["distance"]),
      unit:  distance_unit
    }
    distance.merge meter: meter(distance[:goal]), intensity_class: intensity_class(distance[:goal])
  end

  def active
    active = {
      today: summary["veryActiveMinutes"],
      goal:  percentage(summary["veryActiveMinutes"], goals["activeMinutes"])
    }
    active.merge meter: meter(active[:goal]), intensity_class: intensity_class(active[:goal])
  end

  def leaderboard
    friends = sorted_leaderboard.map do |friend|
      {
        rank:   friend["rank"]["steps"],
        steps:  friend["summary"]["steps"],
        name:   friend["user"]["displayName"],
        avatar: friend["user"]["avatar"],
        style:  leaderboard_style(friend)
      }
    end
  end

  def errors?
    devices.is_a?(Hash) && devices.has_key?("errors")
  end

  def error
    devices["errors"].first["message"]
  end

  def correct_distance distance
    distance_unit == 'miles' ? (distance * 0.621).round(2) : distance
  end

  private

  def devices
    @devices ||= client.devices[:body]
  end

  def current_device
    devices.first
  end

  def today
    @today ||= client.daily_activity_summary(Date.today)
  end

  def total
    @total ||= client.lifetime_stats['lifetime']["total"]
  end

  def distance_unit
    @distance_unit ||= (client.user_info["user"]["distanceUnit"] == "en_US" ? "miles" : "km")
  end

  def distance_today
    correct_distance summary["distances"].select { |item| item["activity"] == "total" }.first["distance"]
  end

  def summary
    today["summary"]
  end

  def goals
    @goals ||= client.goals('daily')["goals"]
  end

  def sorted_leaderboard
    @sorted_leaderboard ||= client.friends_leaderboard["friends"].sort { |one, other| one["rank"]["steps"] <=> other["rank"]["steps"] }.take 5
  end

  def leaderboard_style(friend)
    me?(friend["user"]["encodedId"]) ? "me" : ""
  end

  def me?(id)
    config[:oauth][:user_id] == id
  end

  def percentage(current, total)
    (current.to_f / (total.to_f / 100)).to_i
  end

  def meter(percentage)
    percentage > 100 ? 100 : percentage
  end

  def intensity_class(percentage)
    intensity = case percentage
    when 0..40
      "none"
    when 41..65
      "light"
    when 66..99
      "moderate"
    else
      "high"
    end

    "intensity_#{intensity}"
  end
end
