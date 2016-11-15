class JsonWebToken
  def self.encode(payload)
    exp_time = Time.now.to_i + 4.hours
    issued_at = Time.now.to_i
    payload[:iat] = issued_at
    payload[:exp] = exp_time
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
  rescue JWT::VerificationError
    nil
  rescue JWT::ExpiredSignature
    nil
  end
end
