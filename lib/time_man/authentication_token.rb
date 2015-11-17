require 'jwt'

class AuthenticationToken
  def self.issue_token(payload)
    payload['exp'] = 1.week.from_now.to_i # Set expiration to 1 week.
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      nil
    end
  end
end