# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Connector
    describe Item do
      subject { item }

      let(:organization) { create(:organization) }
      let(:set) { create(:connector_set, organization:) }
      let(:item) { create(:connector_item, set:, remote_id: "ext-001", data: { title: "Hello", status: "active" }) }

      it { is_expected.to be_valid }

      describe "associations" do
        it "belongs to a set" do
          expect(item.set).to eq(set)
        end
      end

      describe "data" do
        it "stores and retrieves JSON data" do
          expect(item.data).to eq("title" => "Hello", "status" => "active")
        end
      end

      describe "timestamps" do
        it "sets created_at and updated_at" do
          expect(item.created_at).to be_present
          expect(item.updated_at).to be_present
        end
      end

      describe ".data scope" do
        let!(:item1) { create(:connector_item, set:, data: { value: "one" }) }
        let!(:item2) { create(:connector_item, set:, data: { value: "two" }) }

        it "plucks the data column from all items" do
          result = set.items.data

          expect(result).to contain_exactly(
            { "value" => "one" },
            { "value" => "two" }
          )
        end
      end
    end
  end
end
