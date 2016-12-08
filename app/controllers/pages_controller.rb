class PagesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:map_display]
  respond_to :html, :json

  def map_display
    @subscriber_coordinates = Subscriber.pluck(:longitude, :latitude)
  end

  def irl_gbr
  end

  def subscriber_coordinates
    mailchimp = Mailchimp::API.new(ENV['MAILCHIMP_API_KEY'])
    subscribers = []
    @coordinates = []

    0.step do |n|
      result = mailchimp.lists.members(ENV['MAILCHIMP_LIST_ID'],"subscribed", {"start" => n, "limit" => 100})['data']
      subscribers = subscribers + result
      break if result.empty?
    end

    subscribers.each do |subscriber|
      ip_locator_result = Geocoder.search(subscriber['ip_opt'])
      if ip_locator_result.first.latitude
        @coordinates << [ip_locator_result.first.longitude, ip_locator_result.first.latitude]
      end
    end

    #convert IP addresses to long lat coordinates

    render :json => @coordinates
  end

  def world_data
    @data = File.read("#{Rails.root}/app/assets/data/world.json")
    render :json => @data
  end

  def irl_gbr_data
    @data = File.read("#{Rails.root}/app/assets/data/ireland_great_britain.json")
    render :json => @data
  end
end
