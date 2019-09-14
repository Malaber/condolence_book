class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :text
      t.string :email
      t.string :tag
      t.boolean :confirmed?
      t.boolean :published?

      t.timestamps
    end
  end
end
