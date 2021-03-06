class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :text
      t.text :image
      t.references :user,     foreign_key: true, null: false
      t.references :group,    foreign_key: true, null: false
      t.timestamps            null: false
    end
  end
end
