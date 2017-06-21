class AddAuthProviderToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :auth_provider, :string, :after => :password, :default => :krb
  end

  def self.down
    remove_column :users, :auth_provider
  end
end
