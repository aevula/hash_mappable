# frozen_string_literal: true

module HashMappable
  module Examples
    class MergeRequest
      class Register < HashMappable::Register
        include Core::DataFetcher

        def first
          chain!(:value) { |rslt| rslt&.first }
        end

        def as_user
          chain!(:value) do |rslt|
            fetch_data(
              query: { github_login: rslt&.dig(:login) },
              mdata: { other_name: "other_#{rslt&.dig(:login)}" }
            )
          end
        end

        def as_state
          chain!(:value) { |_, src| src[:merged] ? :merged : :created }
        end
      end

      include HashMappable

      include Core::DataFetcher
      include Core::Example

      def call
        as_mapped_data
      end

      def fetch!
        fetch_data
      end
    end
  end
end

require_relative 'initializers/merge_request'
