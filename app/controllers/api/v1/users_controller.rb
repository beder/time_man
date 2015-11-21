class Api::V1::UsersController < Api::V1::ApiController
  include TokenAuthenticationHandler
  load_and_authorize_resource

  def create
    @user.save
  end

  def index
  end

  def show
  end

  def update
    @user.update_attributes(update_params)
  end

  def destroy
    @user.destroy
    head(:ok)
  end

  protected

  def create_params
    attributes = %i(first_name last_name role email hours_per_day password password_confirmation)
    attributes << :role if current_user.role.to_sym == :admin
    params.require(:user).permit(*attributes)
  end

  def update_params
    attributes = %i(first_name last_name email hours_per_day)
    attributes << :role if current_user.role.to_sym == :admin
    params.require(:user).permit(*attributes)
  end
end
