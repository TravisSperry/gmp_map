class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  def new_subscriber
    # verify token
    unless params.empty?
      @subscriber = Subscriber.new(subscriber_params)

      respond_to do |format|
        if @subscriber.save
          # Pusher.trigger('test_channel', 'my_event', {
          #   message: 'hello world'
          # })

          render :nothing => true, :status => 200
        else

        end
      end
    else
      render :nothing => true, :status => 200
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
