class WebauthnValidator < ActiveModel::Validator
  def validate(record)
    wa_credential = WebAuthn::Credential.from_create record.webauthn_credential_params
    wa_credential.verify(record.challenge)
  rescue WebAuthn::Error => e
    record.errors.add :base, "Couldn't verify webauthn"
    Rails.logger.error e
    Rails.logger.error e.backtrace
    raise e
    return false
  end
end