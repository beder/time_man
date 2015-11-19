class Api::V1::ActivitiesController < Api::V1::ApiController
  before_action :load_activities, only: :index
  before_action :load_activity, only: [:update, :destroy]

  def create
    @activity = user.activities.create(activity_params)
    render status: :created
  end

  def index
    @activities = @activities.happened_after(params[:date_from])
                             .happened_before(params[:date_to])
  end

  def update
    @activity.update(activity_params)
  end

  def destroy
    user.activities.destroy(@activity)
    head(:ok)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :date, :hours)
  end

  def load_activity
    @activity = user.activities.find(params[:id])
  end

  def load_activities
    @activities = user.activities
  end

  def user
    current_user
  end
end
