class DataSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    if CompanyUser.exists?(company_id: params[:company_id], user_id: current_user) || current_user.role == 'owner'
      @data_sheets = DataSheet.where(company_id: params[:company_id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def new
    if CompanyUser.exists?(company_id: params[:company_id], user_id: current_user) && current_user.role == 'admin'
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
      flash[:notice] = 'Data sheet added successfully.'
      redirect_to company_data_sheets_path(params[:company_id])
    else
      flash[:alert] = @data_sheet.errors.full_messages.join(', ')
      redirect_to new_company_data_sheet_path(params[:company_id])
    end
  end

  def edit
    if (CompanyUser.exists?(company_id: params[:company_id], user_id: current_user) && current_user.role == 'admin') || current_user.role == 'owner'
      @company = Company.find(params[:company_id])
      @data_sheet = DataSheet.find(params[:id])
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  def update
    @data_sheet = DataSheet.find(params[:id])
    @data_sheet.company_id = params[:company_id]
    if @data_sheet.update_attributes(data_sheet_params)
      flash[:notice] = 'Data sheet edited successfully.'
      redirect_to company_data_sheets_path(params[:company_id])
    else
      flash[:alert] = @data_sheet.errors.full_messages.join(', ')
      redirect_to new_company_data_sheet_path(params[:company_id])
    end
  end

  def destroy
    if (CompanyUser.exists?(company_id: params[:company_id], user_id: current_user) && current_user.role == 'admin') || current_user.role == 'owner'
      data_sheet = DataSheet.find(params[:id])
      data_sheet.destroy
      flash[:notice] = 'Data sheet deleted.'
      redirect_to company_data_sheets_path
    else
      flash[:alert] = "You don't have access to this page!"
      redirect_to root_path
    end
  end

  protected
  def data_sheet_params
    params.require(:data_sheet).permit(:number, :name, :sds)
  end
end
