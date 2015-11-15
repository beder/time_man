class Api::V1::ActivitiesController < Api::V1::ApiController
  def index
    @activities = Activity.happened_after(params[:date_from])
                          .happened_before(params[:date_to])
  end
end
