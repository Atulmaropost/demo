class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.integer :mobile_number, :limit => 10
      t.text :description

      t.timestamps
    end
  end
end
