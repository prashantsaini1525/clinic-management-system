class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :disease
      t.string :address
      t.date :registered_on

      t.timestamps
    end
  end
end
