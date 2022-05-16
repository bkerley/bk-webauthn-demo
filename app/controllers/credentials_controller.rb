class CredentialsController < ApplicationController
  def new
    @credential = current_user.credentials.build
    @create_options = WebAuthn::Credential.options_for_create(
      user: {
        id: current_user.webauthn_id,
        name: current_user.name,
      },
      exclude: current_user.credentials.pluck(:external_id)
    )

    session[:current_registration] = { challenge: @create_options.challenge }
  end

  def create
    @credential = current_user.credentials.build credential_params
    @credential.challenge = session["current_registration"]["challenge"]

    if @credential.save
      flash[:success] = "Added credential #{@credential.name}"
      return redirect_to dashboard_path
    end

    @credential.response = nil
    @credential.challenge = nil

    flash[:error] = @credential.errors

    render action: 'new'
  end

  private
  def credential_params
    params.
      require(:credential).
      permit(:name, :response)
  end
end
