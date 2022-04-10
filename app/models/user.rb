class User < ApplicationRecord
  has_secure_password

  after_initialize :set_webauthn_id

  private
  def set_webauthn_id
    self.webauthn_id ||= WebAuthn.generate_user_id
  end
end
