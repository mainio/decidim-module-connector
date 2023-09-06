# frozen_string_literal: true

class CreateDecidimConnectorSets < ActiveRecord::Migration[6.1]
  def change
    create_table :decidim_connector_sets do |t|
      t.references :decidim_organization, foreign_key: true
      t.string :key, null: false, index: true
      t.jsonb :config
    end

    add_index :decidim_connector_sets, [:decidim_organization_id, :key], unique: true, name: "decidim_connector_sets_organization_key_unique"
  end
end
