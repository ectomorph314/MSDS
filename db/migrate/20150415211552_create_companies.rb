class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :user, foreign_key: true

      t.index :name, unique: true
    end
  end
end
