class Api::V1::UsersController < Devise::RegistrationsController

  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    head :conflict and return if !resource.valid? && resource.errors[:email].include?('has already been taken')
    resource.save ? head(:created) : raise(ArgumentError.new(@user.errors.messages))
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
end
