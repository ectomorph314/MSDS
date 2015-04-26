class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'owner'
      @users = User.order(:role, :email)
    elsif current_user.role == 'admin'
      @users = []
      if !current_user.company_user.nil?
        company_id = current_user.company_user.company.id
        CompanyUser.where(company_id: company_id).find_each do |job|
          @users << User.find(job.user_id)
        end
      end
      User.find_each do |user|
        if !CompanyUser.exists?(user_id: user.id)
          @users << User.find(user.id)
        end
      end
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def edit
    if (current_user.role == 'admin' && (!CompanyUser.exists?(user_id: params[:id]) || CompanyUser.exists?(company_id: current_user.company.id, user_id: params[:id]))) || current_user.role == 'owner'
      @user = User.find(params[:id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    record = CompanyUser.find_or_initialize_by(user_id: @user.id)
    record.update_attributes(company_id: params['user']['company'], user_id: @user.id)
    flash[:success] = 'User edited successfully.'
    redirect_to users_path
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    flash[:success] = 'User deleted.'
    redirect_to users_path
  end

  protected
  
  def user_params
    params.require(:user).permit(:role)
  end
end
