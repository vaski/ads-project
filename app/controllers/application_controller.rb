class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
