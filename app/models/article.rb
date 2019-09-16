class Article < ApplicationRecord

  before_create :generate_confirmation_token
  before_create :generate_publish_token

  def next_published
    self.class.where("id > ? AND published = ?", id, true).first
  end

  def previous_published
    self.class.where("id < ? AND published = ?", id, true).last
  end

  def email_activate
    self.confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def generate_confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def generate_publish_token
    if publish_token.blank?
      self.publish_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
