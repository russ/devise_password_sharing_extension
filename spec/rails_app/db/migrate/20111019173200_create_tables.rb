class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.database_authenticatable :null => true
      t.confirmable
      t.recoverable
      t.lockable
      t.timestamps
      t.password_sharing
    end

    create_table :login_events do |t|
      t.integer :user_id
      t.string :ip_address
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :country_code
      t.string :region_name
      t.datetime :created_at
    end
  end

  def self.down
    drop_table :users
    drop_table :login_histories
  end
end
