class CreateShortenedUrl < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url, null: false
      t.integer :user_id
    end

    add_index :shortened_urls, [:long_url, :short_url], :unique => true
  end
end
