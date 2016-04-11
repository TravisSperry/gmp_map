class SubscribersController < ApplicationController
  # before_action :set_subscriber, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, :only => [:new_subscriber]

  def new_subscriber
    if params.has_key?(:data)
      p params
      ip_locator_result = Geocoder.search(params['data']['ip_opt'])

      @subscriber = Subscriber.new  longitude: ip_locator_result.first.longitude,
                                    latitude: ip_locator_result.first.longitude
    end
    respond_to do |format|
      if @subscriber && @subscriber.save
        Pusher.trigger('test_channel', 'my_event', {
          message: 'hello world'
        })
        format.html{ render nothing: true }
      else
        format.html{ render nothing: true }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_subscriber
    #   @subscriber = Subscriber.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscriber_params
      params.require(:subscriber).permit(:longitude, :latitude)
    end
end
