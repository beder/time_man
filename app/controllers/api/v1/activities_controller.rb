class Api::V1::ActivitiesController < Api::V1::ApiController
  load_and_authorize_resource

  def create
    @activity.save
    render status: :created
  end

  def index
    @activities = @activities.happened_after(params[:date_from])
                             .happened_before(params[:date_to])
  end

  def update
    @activity.update_attributes(activity_params)
  end

  def destroy
    user.activities.destroy(@activity)
    head(:ok)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :date, :hours)
  end

  def user
    current_user
  end
end
