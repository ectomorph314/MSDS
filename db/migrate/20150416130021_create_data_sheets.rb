class CreateDataSheets < ActiveRecord::Migration
  def change
    create_table :data_sheets do |t|
      t.string :number, null: false
      t.string :name, null: false
      t.string :sds, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
