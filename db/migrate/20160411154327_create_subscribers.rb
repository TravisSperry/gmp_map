class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
