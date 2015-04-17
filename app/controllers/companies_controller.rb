class CompaniesController < ApplicationController
  before_action :authenticate_user!

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.user = current_user
    if @company.save
      flash[:notice] = 'Company added successfully.'
      redirect_to company_path(@company)
    else
      flash[:alert] = @company.errors.full_messages.join(', ')
      redirect_to new_company_path
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:notice] = 'Company edited successfully.'
      redirect_to company_path(@company)
    else
      flash[:alert] = @company.errors.full_messages.join(', ')
      redirect_to edit_company_path(@company.id)
    end
  end

  def delete
  end

  protected
  def company_params
    params.require(:company).permit(:name)
  end
end
