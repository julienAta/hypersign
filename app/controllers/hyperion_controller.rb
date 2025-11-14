# frozen_string_literal: true

class HyperionController < ApplicationController
  skip_before_action :authenticate_user!
  skip_authorization_check
  skip_forgery_protection only: [:auto_login]

  JWT_SECRET = ENV.fetch('DOCUSEAL_JWT_SECRET', 'hyperion-docuseal-secret-change-in-production')

  def auto_login
    token = params[:token]
    redirect_to_path = params[:redirect_to] || '/templates/new?embedded=true'

    unless token
      render plain: 'Missing authentication token', status: :bad_request
      return
    end

    begin
      # Verify and decode JWT token
      decoded = JWT.decode(token, JWT_SECRET, true, { algorithm: 'HS256' })
      payload = decoded.first

      email = payload['email']
      first_name = payload['firstName']
      last_name = payload['lastName']
      hyperion_user_id = payload['hyperionUserId']

      # Find or create user
      user = User.find_by(email: email)

      unless user
        # Create account if doesn't exist
        account = Account.find_or_create_by!(
          name: "Hyperion - #{email}"
        )

        # Create user
        user = User.create!(
          email: email,
          first_name: first_name,
          last_name: last_name,
          password: SecureRandom.hex(32), # Random password - won't be used
          account: account
        )
      end

      # Sign in the user
      sign_in(user)

      # Redirect to requested path with embedded flag
      redirect_to redirect_to_path, allow_other_host: false
    rescue JWT::DecodeError, JWT::ExpiredSignature => e
      render plain: "Invalid or expired token: #{e.message}", status: :unauthorized
    rescue StandardError => e
      Rails.logger.error("Auto-login error: #{e.message}")
      render plain: 'Authentication failed', status: :internal_server_error
    end
  end

  def template_builder
    # Embedded template builder view with no navigation
    render layout: 'hyperion_embedded'
  end
end
