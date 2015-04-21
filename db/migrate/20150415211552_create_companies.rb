class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :user

      t.index :name, unique: true
    end
  end
end
