class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :email
      t.boolean :confirmed?
      t.boolean :published?

      t.timestamps
    end
  end
end
