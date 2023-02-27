# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    if current_user.present?
      flash[:notice] = t('.already_login')
      redirect_to(root_path) 
    end
  end

  def create
    email = params[:session][:email].downcase
    user = User.find_by(email: email)
    session[:email] = email

    unless user.present?
      flash[:alert] = t('.email_does_not_exist')
      return render :new
    end

    if(user.authenticate(params[:session][:password]))
      log_in user
      session.delete(:email)
      binding.pry
      if params[:session][:remember_me] == '1'
        remember(user)
      end
      redirect_to(root_path, flash: { notice: t('.login_successfully') })
    else
      flash[:alert] = t('.incorrect_password')
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:notice] = t('.logout_successfully')
    redirect_to sign_in_path
  end
end
