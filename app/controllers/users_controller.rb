# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /sign_up
  def new
    @user = User.new
  end

  # POST /sign_up
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = t('.register_success')
      UserMailer.confirmation_user_mail(@user).deliver_now
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  def confirmation
    user = User.find_by(email: params[:email])

    if user.confirmed_at.present?
      return redirect_to(sign_in_path, flash: { alert: t('.already_comfirmed')})
    end

    unless user.present? || user.confirmation_token == params[:token]
      redirect_to(root_path, flash: { alert: t('.confirmation_failure') })
    end

    user.confirmed_at = Time.current
    if user.save
      redirect_to(sign_in_path, flash: { notice: t('.confirmation_success') })
    else
      redirect_to(root_path, flash: { alert: t('.confirmation_failure') })
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
