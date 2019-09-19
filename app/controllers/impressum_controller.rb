# frozen_string_literal: true

class ImpressumController < ApplicationController
  def get
    @impressum = true
    render 'impressum'
  end
end
