class CredentialsController < ApplicationController
  def new
    @credential = current_user.credentials.build
  end

  def create
    @create_options = WebAuthn::Credential.options_for_create(
      user: {
        id: current_user.webauthn_id,
        name: current_user.username,
      },
      exclude: current_user.credentials.pluck(:external_id)
    )
    @create_options['name'] = params[:credential][:name]

    session[:current_new_credential] =
      { challenge: @create_options.challenge }
  end
end
