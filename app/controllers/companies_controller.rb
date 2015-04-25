class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.role == 'owner'
      @companies = Company.all.order(:name)
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def show
    if CompanyUser.exists?(company_id: params[:id], user_id: current_user) || current_user.role == 'owner'
      @company = Company.find(params[:id])
      @data_sheets = DataSheet.search(params[:search]).where(company_id: params[:id]).order(:number)
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def new
    if !CompanyUser.exists?(user_id: current_user) && current_user.role == 'admin'
      @company = Company.new
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save && CompanyUser.create(company_id: @company.id, user_id: current_user.id)
      flash[:success] = 'Company added successfully.'
      redirect_to company_path(@company)
    else
      flash[:alert] = @company.errors.full_messages.join(', ')
      redirect_to new_company_path
    end
  end

  def edit
    if current_user.admin_access?(params[:id]) || current_user.role == 'owner'
      @company = Company.find(params[:id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = 'Company edited successfully.'
      redirect_to company_path(@company)
    else
      flash[:alert] = @company.errors.full_messages.join(', ')
      redirect_to edit_company_path(@company.id)
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    flash[:success] = 'Company deleted.'
    if current_user.role == 'owner'
      redirect_to companies_path
    else
      redirect_to root_path
    end
  end

  protected
  def company_params
    params.require(:company).permit(:name)
  end
end
