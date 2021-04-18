class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :email
      t.timestamps
    end

    add_index :users, :email
  end
end
