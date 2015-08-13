class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |f|
      f.string :text
      f.integer :user_id

      f.timestamps
    end
  end
end
