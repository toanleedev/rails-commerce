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
      flash[:success] = 'Success!'
      redirect_to(root_path)
    else
      render(:new)
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
  end
end
