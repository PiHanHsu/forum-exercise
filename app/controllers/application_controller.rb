class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  #set Time_zone in Taipei
  Time.zone = "Taipei"
  

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
       session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username << :avatar
    devise_parameter_sanitizer.for(:account_update) << :username << :avatar
  end
end
