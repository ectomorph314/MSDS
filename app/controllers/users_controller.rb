class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'owner'
      @users = User.all
    elsif current_user.role == 'admin'
      company = Company.find_by(user_id: current_user)
      list = CompanyUser.where(company_id: company.id)
      @users = User.where(user_id: list.user_id)
    else
      flash[:notice] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def destroy
    if current_user.role == 'admin' || current_user.role == 'owner'
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = 'User deleted.'
      redirect_to users_path
    else
      flash[:notice] = "You don't have access to this page!"
      redirect_to root_path
    end
  end
end
