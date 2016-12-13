class AttendingsController < ApplicationController
  def create
    attending = Attending.new(attend_params)

    if attending.save()
      redirect_to events_path
    else
      flash[:errors] = attending.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    attending = Attending.find(params[:id])
    attending.destroy()

    redirect_to events_path
  end

  private
  def attend_params
    params.require(:attend).permit(:event_id, :user_id)
  end

end
