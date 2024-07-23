# frozen_string_literal: true

module HashMappable
  class ChainWrapper
    def chain(chain_name)
      (@chains || reset!)[chain_name.to_sym] ||= []
    end

    def reset!
      @chains = {}
    end

    def chain!(chain_name, &block)
      chain(chain_name) << block
      self
    end

    def unchain(chain_name, src)
      result = nil
      chain(chain_name).each.with_index { |link, idx| result = link.call(result, src, idx) }
      result
    end
  end
end
