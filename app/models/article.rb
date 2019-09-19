# frozen_string_literal: true

class Article < ApplicationRecord
  include ActiveModel::Validations
  validates :name, :email, :tag, presence: true

  before_create :generate_confirmation_token
  before_create :generate_publish_token

  def self.all_published
    Article.where('published = ?', true).order(:id)
  end

  def next_published
    self.class.where('id > ? AND published = ?', id, true).first
  end

  def previous_published
    self.class.where('id < ? AND published = ?', id, true).last
  end

  def email_activate!
    self.confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def publish!
    self.published = true
    self.publish_token = nil
    save!(validate: false)
  end

  private

  def generate_confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def generate_publish_token
    self.publish_token = SecureRandom.urlsafe_base64.to_s if publish_token.blank?
  end
end
