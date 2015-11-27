class Api::V1::ActivitiesController < Api::V1::ApiController
  load_and_authorize_resource through: :target_user

  before_action :validate_create_ability, only: :create

  def create
    @activity.save
    render status: :created
  end

  def index
    @activities = @activities.happened_after(params[:date_from])
                             .happened_before(params[:date_to])
                             .oldest_first
  end

  def update
    @activity.update_attributes(activity_params)
  end

  def destroy
    @activity.destroy
    head(:ok)
  end

  private

  def validate_create_ability
    raise CanCan::AccessDenied.new if current_user.id.to_s != params[:user_id].to_s && current_user.role.to_sym != :admin
  end

  def activity_params
    params.require(:activity).permit(:name, :date, :hours)
  end

  def target_user
    User.find(params[:user_id])
  end
end
