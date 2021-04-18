class CreateVisits < ActiveRecord::Migration[6.1]
  def change
    create_table :visits do |t|
      t.integer :short_url_id
      t.integer :user_id
      t.timestamps
    end
  end
end
