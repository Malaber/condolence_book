class FillerController < ApplicationController
  def get
    render 'filler'
  end

  def loader
    render "filler/loader.txt"
  end
end
