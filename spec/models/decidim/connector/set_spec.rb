# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Connector
    describe Set do
      subject { set }

      let(:organization) { create(:organization) }
      let(:set) { create(:connector_set, organization: organization, key: "my_connector") }

      it { is_expected.to be_valid }

      describe "associations" do
        it "belongs to an organization" do
          expect(set.organization).to eq(organization)
        end

        it "has many items" do
          item1 = create(:connector_item, set: set)
          item2 = create(:connector_item, set: set)

          expect(set.items).to contain_exactly(item1, item2)
        end

        it "destroys dependent items" do
          create(:connector_item, set: set)
          create(:connector_item, set: set)

          expect { set.destroy }.to change(Item, :count).by(-2)
        end
      end

      describe "validations" do
        it "requires a unique key per organization" do
          set # force creation
          duplicate = build(:connector_set, organization: organization, key: "my_connector")

          expect(duplicate).not_to be_valid
          expect(duplicate.errors[:key]).to include("has already been taken")
        end

        it "allows the same key for different organizations" do
          other_organization = create(:organization)
          other_set = build(:connector_set, organization: other_organization, key: "my_connector")

          expect(other_set).to be_valid
        end
      end

      describe ".with_organization" do
        let!(:other_organization) { create(:organization) }
        let!(:other_set) { create(:connector_set, organization: other_organization) }

        it "returns sets belonging to the given organization" do
          expect(described_class.with_organization(organization)).to contain_exactly(set)
        end
      end

      describe ".get" do
        it "returns the set for the given organization and key" do
          set # force creation
          result = described_class.get(organization, "my_connector")

          expect(result).to eq(set)
        end

        it "returns nil when the key does not exist" do
          result = described_class.get(organization, "nonexistent")

          expect(result).to be_nil
        end

        it "returns nil when the organization does not match" do
          other_organization = create(:organization)
          result = described_class.get(other_organization, "my_connector")

          expect(result).to be_nil
        end
      end

      describe "#config" do
        let(:set) { create(:connector_set, organization: organization, key: "cfg_test", config: { endpoint: "https://api.example.org", token: "secret" }) }

        it "returns an OpenStruct" do
          expect(set.config).to be_a(OpenStruct)
        end

        it "provides method access to config values" do
          expect(set.config.endpoint).to eq("https://api.example.org")
          expect(set.config.token).to eq("secret")
        end

        context "when config is nil" do
          let(:set) { create(:connector_set, organization: organization, key: "nil_cfg", config: nil) }

          it "returns an empty OpenStruct" do
            expect(set.config).to be_a(OpenStruct)
          end
        end
      end

      describe "#has_remote_item?" do
        let!(:item) { create(:connector_item, set: set, remote_id: "remote-123") }

        it "returns true when the remote item exists" do
          expect(set.has_remote_item?("remote-123")).to be(true)
        end

        it "returns false when the remote item does not exist" do
          expect(set.has_remote_item?("nonexistent")).to be(false)
        end
      end

      describe "#remote_item" do
        let!(:item) { create(:connector_item, set: set, remote_id: "remote-456") }

        it "returns the item with the given remote_id" do
          expect(set.remote_item("remote-456")).to eq(item)
        end

        it "returns nil when no item matches" do
          expect(set.remote_item("missing")).to be_nil
        end
      end
    end
  end
end