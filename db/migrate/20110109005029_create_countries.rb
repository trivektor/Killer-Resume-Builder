class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :country_code
      t.string :country_name
    end
  end

  def self.down
    drop_table :countries
  end
end
