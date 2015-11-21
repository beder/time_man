class Api::V1::ApiController < ActionController::Base
  include TokenAuthenticationHandler
  include HttpErrorHandler

  protect_from_forgery with: :null_session

  respond_to :json

  check_authorization
end
