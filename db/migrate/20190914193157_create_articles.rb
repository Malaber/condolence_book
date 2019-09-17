class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :text
      t.string :email
      t.string :tag
      t.boolean :confirmed, :default => false
      t.string :confirm_token
      t.boolean :published, :default => false
      t.string :publish_token

      t.timestamps
    end
  end
end
