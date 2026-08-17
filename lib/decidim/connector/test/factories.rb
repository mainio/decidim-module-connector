# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :connector_set, class: "Decidim::Connector::Set" do
    organization { association(:organization) }
    key { generate(:title) }
    config { { endpoint: "https://example.org/api", token: "abc123" } }

    trait :with_items do
      transient do
        items_count { 3 }
      end

      after(:create) do |set, evaluator|
        create_list(:connector_item, evaluator.items_count, set: set)
      end
    end
  end

  factory :connector_item, class: "Decidim::Connector::Item" do
    set { association(:connector_set) }
    remote_id { SecureRandom.uuid }
    data { { title: Faker::Lorem.sentence, status: "active" } }
  end
end