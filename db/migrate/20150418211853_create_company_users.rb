class CreateCompanyUsers < ActiveRecord::Migration
  def change
    create_table :company_users do |t|
      t.references :company, null: false
      t.references :user, null: false

      t.index :user_id, unique: true
    end
  end
end
