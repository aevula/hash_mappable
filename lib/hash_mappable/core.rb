# frozen_string_literal: true

module HashMappable
  module Core
    def self.included(base)
      base.include(InstanceMethods)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def configure(&)
        class_eval(&) if block_given?
      end

      def use(register_class)
        @register_class = register_class
      end

      def source_fetcher(fetch_method = nil)
        @source_fetcher ||= fetch_method
      end

      def register(dst_key)
        @register_class ||= ::HashMappable::Register
        registers[dst_key] = @register_class.new.to(dst_key)
      end

      def registers
        @registers ||= {}
      end
    end

    module InstanceMethods
      def as_mapped_data
        source = __send__(self.class.source_fetcher)

        self.class.registers.values.each.with_object({}) do |register, obj|
          register.unpack(source, obj)
        end
      end
    end
  end
end
