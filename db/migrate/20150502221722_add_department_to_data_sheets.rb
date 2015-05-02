class AddDepartmentToDataSheets < ActiveRecord::Migration
  def change
    add_reference :data_sheets, :department, foreign_key: true
  end
end
