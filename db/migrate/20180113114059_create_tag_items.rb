class CreateTagItems < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_items do |t|
      t.references :list_item, foreign_key: true
      t.references :tag, foreign_key: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
