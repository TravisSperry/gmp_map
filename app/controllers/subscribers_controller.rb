class SubscribersController < ApplicationController
  # before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  def new_subscriber
    respond_to do |format|
      if @subscriber && @subscriber.save
        # Pusher.trigger('test_channel', 'my_event', {
        #   message: 'hello world'
        # })
        format.html{ render nothing:true }
      else
        format.html{ render nothing:true }
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
