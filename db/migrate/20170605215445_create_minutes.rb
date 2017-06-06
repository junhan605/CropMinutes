class CreateMinutes < ActiveRecord::Migration[5.0]
  def change
    create_table :minutes do |t|
      t.string :company_type
      t.string :location
      t.boolean :secretary
      t.boolean :president
      t.boolean :director
      t.boolean :treasurer
      t.string :other_party
      t.string :escriibe_property

      t.timestamps
    end
  end
end
