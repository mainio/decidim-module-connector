# frozen_string_literal: true

module Decidim
  module Connector
    class Item < ApplicationRecord
      belongs_to :set, class_name: "Decidim::Connector::Set", foreign_key: "decidim_connector_set_id"

      scope :data, -> { pluck(:data) }
    end
  end
end
