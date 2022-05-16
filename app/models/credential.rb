class Credential < ApplicationRecord
  belongs_to :user

  validates_with WebauthnValidator

  attr_accessor :challenge
  attr_accessor :response

  def webauthn_credential_params
    JSON.parse(response)
  end
end
