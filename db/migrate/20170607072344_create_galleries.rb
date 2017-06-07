class CreateGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :galleries do |t|
      t.integer :user_id
      t.string :name
      t.string :gallery_image

      t.timestamps
    end
  end
end
