class UsersTableSetup < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name
      t.text :email
      t.text :password
      t.timestamps
    end
  end
end
