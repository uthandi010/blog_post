class ApplicationController < ActionController::Base
  include Clearance::Controller
  # include ErrorRenderer
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_login
    unless signed_in?
      redirect_to sign_in_path, alert: "You need to sign in to perform this action."
    end
  end
end
