# frozen_string_literal: true

require 'byebug'
require 'hash_mappable'

require_relative 'core/data_fetcher'
require_relative 'core/example'

require_relative 'chain_wrapper'
require_relative 'merge_request'

module HashMappable
  module Examples
    VERBOSE = ENV.fetch('EXAMPLES_VERBOSE', false)
    public_constant :VERBOSE

    def self.call
      ChainWrapper.call
      MergeRequest.call

      true
    end
  end
end
