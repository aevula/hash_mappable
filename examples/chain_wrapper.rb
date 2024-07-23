# frozen_string_literal: true

module HashMappable
  module Examples
    class ChainWrapper < HashMappable::ChainWrapper
      include Core::DataFetcher
      include Core::Example

      def initialize
        super

        chain_mr_state
        chain_assignee
        chain_reviewer
      end

      def call
        body = fetch_data
        {
          mr_state: unchain(:mr_state, body),
          assignee: unchain(:assignee, body),
          reviewer: unchain(:reviewer, body)
        }
      end

      private

      def chain_mr_state
        chain!(:mr_state) { |_, src| src[:merged] }
      end

      def chain_assignee
        chain!(:assignee) { |_, src| src[:assignee] }
          .chain!(:assignee) { |rslt| rslt[:login] }
      end

      def chain_reviewer
        chain!(:reviewer) { |_, src| src[:requested_reviewers] }
          .chain!(:reviewer) { |rslt, _,| rslt.first }
          .chain!(:reviewer) { |rslt| rslt[:login] }
          .chain!(:reviewer) { |rslt| fetch_data(mdata: { name: rslt }) }
          .chain!(:reviewer) { |rslt| rslt[:name] }
      end
    end
  end
end
