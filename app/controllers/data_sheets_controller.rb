class DataSheetsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.admin_access?(params[:company_id])
      @company = Company.find(params[:company_id])
      @data_sheet = DataSheet.new
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def create
    @data_sheet = DataSheet.new(data_sheet_params)
    @data_sheet.company_id = params[:company_id]
    if @data_sheet.save
      flash[:success] = 'Data sheet added successfully.'
      redirect_to company_path(params[:company_id])
    else
      flash[:alert] = @data_sheet.errors.full_messages.join(', ')
      redirect_to new_company_data_sheet_path(params[:company_id])
    end
  end

  def edit
    if current_user.admin_access?(params[:company_id]) || current_user.role == 'owner'
      @company = Company.find(params[:company_id])
      @data_sheet = DataSheet.find(params[:id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def update
    @data_sheet = DataSheet.find(params[:id])
    if @data_sheet.update_attributes(data_sheet_params)
      flash[:success] = 'Data sheet edited successfully.'
      redirect_to company_path(params[:company_id])
    else
      flash[:alert] = @data_sheet.errors.full_messages.join(', ')
      redirect_to new_company_data_sheet_path(params[:company_id])
    end
  end

  def destroy
    data_sheet = DataSheet.find(params[:id])
    data_sheet.destroy
    flash[:success] = 'Data sheet deleted.'
    redirect_to company_path(params[:company_id])
  end

  protected

  def data_sheet_params
    params.require(:data_sheet).permit(:number, :name, :sds)
  end
end
