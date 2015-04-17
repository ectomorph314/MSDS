class DataSheetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @data_sheets = DataSheet.where(company_id: params[:company_id])
  end

  def new
    @company = Company.find(params[:company_id])
    @data_sheet = DataSheet.new
  end

  def create
    @data_sheet = DataSheet.new(data_sheet_params)
    @data_sheet.company_id = params[:company_id]
    if @data_sheet.save
      flash[:notice] = 'Data Sheet added successfully.'
      redirect_to company_data_sheets_path(params[:company_id])
    else
      flash[:alert] = @data_sheet.errors.full_messages.join(', ')
      redirect_to new_company_data_sheet_path(params[:company_id])
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  protected
  def data_sheet_params
    params.require(:data_sheet).permit(:name, :description, :sds)
  end
end
