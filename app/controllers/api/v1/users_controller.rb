class Api::V1::UsersController < Api::V1::ApiController
  include TokenAuthenticationHandler

  before_action :load_user, only: [:show, :update]

  def show
  end

  def update
    @user.update(update_user_params)
  end

  protected

  def load_user
    @user = current_user
  end

  def update_user_params
    params.require(:user).permit(:hours_per_day)
  end
end
