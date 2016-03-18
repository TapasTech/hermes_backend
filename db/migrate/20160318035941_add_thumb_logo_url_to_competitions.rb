# frozen_string_literal: true
class AddThumbLogoURLToCompetitions < ActiveRecord::Migration[5.0]
  def change
    add_column :competitions, :thumb_logo_url, :text
  end
end
