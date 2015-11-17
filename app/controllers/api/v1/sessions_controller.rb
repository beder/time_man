class Api::V1::SessionsController < Devise::SessionsController
  include Devise::Controllers::Helpers

  protect_from_forgery with: :null_session

  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options.merge(store: false))
    sign_in(resource_name, resource, store: false)
    @token = AuthenticationToken.issue_token({ user_id: resource.id })
  end
end
