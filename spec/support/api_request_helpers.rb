module ApiRequestHelpers
  def default_request(user = nil)
    set_accept
    set_authorization(user)
  end

  def set_accept
    request.env['HTTP_ACCEPT'] = 'application/json'
  end

  def set_authorization(user = nil)
    return unless user.present?
    token = AuthenticationToken.issue_token({ user_id: user.id })
    request.env['HTTP_AUTHORIZATION'] = "Token token=#{token}"
  end
end
