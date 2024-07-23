# frozen_string_literal: true

module HashMappable
  module Examples
    module Core
      module Example
        def self.included(base)
          base.extend(ClassMethods)
        end

        module ClassMethods
          def call
            puts("Starting #{name}") if HashMappable::Examples::VERBOSE
            data = new.call
            return unless HashMappable::Examples::VERBOSE

            puts(data)
            puts
          end
        end
      end
    end
  end
end
