# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale
  include SessionsHelper

  private

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def default_url_options
    { locale: set_locale }
  end
end
