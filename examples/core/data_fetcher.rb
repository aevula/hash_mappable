# frozen_string_literal: true

module HashMappable
  module Examples
    module Core
      module DataFetcher
        def self.included(base)
          base.include(InstanceMethods)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def data(object = nil)
            @data ||= object || example_object
          end

          def example_object
            { id: :m1, html_url: :uri, merged: false }.merge(assignee).merge(reviewers)
          end

          def assignee
            {
              assignee: { id: :ai1, login: :al1 }
            }
          end

          def reviewers
            {
              requested_reviewers: [
                { id: :ri1, login: :rl1 },
                { id: :ri2, login: :rl2 }
              ]
            }
          end
        end

        module InstanceMethods
          def fetch_data(query: nil, mdata: self.class.data)
            puts("Fetching #{query.inspect}") if query && HashMappable::Examples::VERBOSE
            mdata
          end
        end
      end
    end
  end
end
