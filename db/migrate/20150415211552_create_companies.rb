class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :user, null: false

      t.index :name, unique: true
    end
  end
end
