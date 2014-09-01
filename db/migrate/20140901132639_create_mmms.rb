class CreateMmms < ActiveRecord::Migration
  def change
    create_table :mmms do |t|
      t.string :mdu
      t.string :adress
      t.string :porch
      t.string :ip
      t.string :sys_name
      t.string :ingress
      t.boolean :mod

      t.timestamps
    end
  end
end
