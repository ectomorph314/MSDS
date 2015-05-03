class DepartmentsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.admin_access?(params[:company_id])
      @company = Company.find(params[:company_id])
      @department = Department.new
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def create
    @department = Department.new(department_params)
    @department.company_id = params[:company_id]
    if @department.save
      flash[:success] = 'Department added successfully.'
      redirect_to company_path(params[:company_id])
    else
      flash[:alert] = @department.errors.full_messages.join(', ')
      redirect_to new_company_department_path
    end
  end

  def edit
    if current_user.admin_access?(params[:company_id]) || current_user.role == 'owner'
      @company = Company.find(params[:company_id])
      @department = Department.find(params[:id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def update
    @department = Department.find(params[:id])
    if @department.update_attributes(department_params)
      flash[:success] = 'Department edited successfully.'
      redirect_to company_path(params[:company_id])
    else
      flash[:alert] = @department.errors.full_messages.join(', ')
      redirect_to edit_company_department_path(params[:company_id], @department)
    end
  end

  def destroy
    department = Department.find(params[:id])
    department.destroy
    flash[:success] = 'Department deleted.'
    redirect_to company_path(params[:company_id])
  end

  protected

  def department_params
    params.require(:department).permit(:name)
  end
end
