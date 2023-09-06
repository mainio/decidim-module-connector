# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Connector
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Connector
    end
  end
end
