class Api::V1::ApiController < ActionController::Base
  include TokenAuthenticationHandler

  protect_from_forgery with: :null_session

  respond_to :json
end
