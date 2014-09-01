class CreateAvrs < ActiveRecord::Migration
  def change
    create_table :avrs do |t|
      t.integer :mmm_id
      t.string :type_avr
      t.string :material
      t.string :comment
      t.integer :user_id
      t.datetime :date_on
      t.datetime :date_off

      t.timestamps
    end
  end
end
