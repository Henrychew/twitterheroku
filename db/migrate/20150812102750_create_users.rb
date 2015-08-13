class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |f|
      f.string :username
      f.string :access_token
      f.string :access_secret

      f.timestamps
    end
  end
end
