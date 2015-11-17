module TokenAuthenticationHandler
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_from_token!
  end

  def authenticate_from_token!
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, _options|
      decoded_token = AuthenticationToken.decode(token)
      next if decoded_token.blank?

      sign_in_user(decoded_token)
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render :status => :unauthorized, json: { status: 401, error: 'Unauthorized' }
  end

  def sign_in_user(decoded_token)
    payload = decoded_token.select {|h| h['user_id'].present? }.first
    return if payload.blank?

    user = User.find(payload['user_id'])

    # Notice we are passing store false, so the user is not
    # actually stored in the session and a token is needed
    # for every request. If you want the token to work as a
    # sign in token, you can simply remove store: false.
    sign_in(user, store: false, run_callbacks: false) if user
  end
end
