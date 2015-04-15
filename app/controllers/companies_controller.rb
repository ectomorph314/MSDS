class CompaniesController < ApplicationController
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
      flash[:alert] = @company.errors.full_messages
      redirect_to new_company_path
    end
  end

  protected
  def company_params
    params.require(:company).permit(:name)
  end
end