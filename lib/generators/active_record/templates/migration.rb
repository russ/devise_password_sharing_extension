class DevisePasswordSharingAddTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    change_table :<%= table_name %> do |t|
      t.datetime :banned_for_password_sharing, :default => false
    end

    create_table :login_events do |t|
      t.integer :<%= table_name.singularize.underscore %>_id
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
    change_table :<%= table_name %> do |t|
      t.remove :banned_for_password_sharing
    end

    drop_table :login_events
  end
end
