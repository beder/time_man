class Api::V1::RegistrationsController < Devise::RegistrationsController
  include HttpErrorHandler
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters

  def create
    build_resource(sign_up_params)
    raise(ArgumentError.new(resource.errors.full_messages)) unless resource.save
    sign_in(resource_name, resource, store: false)
    @token = AuthenticationToken.issue_token({ user_id: resource.id })
    render(status: :created)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
  end
end
