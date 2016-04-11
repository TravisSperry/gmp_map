class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :longitude
      t.string :latitude

      t.timestamps
    end
  end
end
