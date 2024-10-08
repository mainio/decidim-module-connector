# frozen_string_literal: true

module Decidim
  module Connector
    class Set < ApplicationRecord
      belongs_to :organization, foreign_key: "decidim_organization_id", class_name: "Decidim::Organization"
      has_many :items, class_name: "Decidim::Connector::Item", foreign_key: "decidim_connector_set_id", dependent: :destroy

      scope :with_organization, ->(organization) { where(organization:) }

      validates :key, uniqueness: { scope: :organization }

      def self.get(organization, key)
        with_organization(organization).find_by(key:)
      end

      def config
        OpenStruct.new(super)
      end

      def has_remote_item?(remote_id)
        remote_item(remote_id).present?
      end

      def remote_item(remote_id)
        items.find_by(remote_id:)
      end
    end
  end
end
