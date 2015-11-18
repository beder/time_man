class Api::V1::ActivitiesController < Api::V1::ApiController
  def create
    @activity = Activity.create(create_activity_params)
    render status: :created
  end

  def index
    @activities = Activity.happened_after(params[:date_from])
                          .happened_before(params[:date_to])
  end

  private

  def create_activity_params
    params.require(:activity).permit(:name, :date, :hours)
  end
end
