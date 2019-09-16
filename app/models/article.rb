class Article < ApplicationRecord
  def next_published
    self.class.where("id > ? AND published = ?", id, true).first
  end

  def previous_published
    self.class.where("id < ? AND published = ?", id, true).last
  end
end
