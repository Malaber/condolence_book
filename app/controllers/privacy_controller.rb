# frozen_string_literal: true

class PrivacyController < ApplicationController
  def get
    @privacy = true
    render 'privacy'
  end
end
