class Api::V1::ActivitiesController < Api::V1::ApiController
  before_action :load_activity, only: [:update, :destroy]

  def create
    @activity = Activity.create(activity_params)
    render status: :created
  end

  def index
    @activities = Activity.happened_after(params[:date_from])
                          .happened_before(params[:date_to])
  end

  def update
    @activity.update(activity_params)
  end

  def destroy
    @activity.destroy
    head(:ok)
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :date, :hours)
  end

  def load_activity
    @activity = Activity.find(params[:id])
  end
end
