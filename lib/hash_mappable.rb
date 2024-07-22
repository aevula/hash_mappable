# frozen_string_literal: true

require 'hash_mappable/version'

require 'hash_mappable/chain_wrapper'
require 'hash_mappable/register'
require 'hash_mappable/core'

module HashMappable
  def self.append_features(base)
    base.include(Core)
  end
end
