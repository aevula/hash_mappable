# frozen_string_literal: true

module HashMappable
  class Register < ChainWrapper
    def to(dst_key)
      chain!(:key) { dst_key }
    end

    def from(*path)
      chain!(:value) do |prev_link_rslt, src, link_idx|
        fetch(link_idx.zero? ? src : prev_link_rslt, *path)
      end
    end

    def unpack(src, obj = nil)
      return [resolved_key(src), resolved_value(src)] unless obj

      obj[resolved_key(src)] = resolved_value(src) if resolved_key(src)
    end

    private

    def fetch(data, *path)
      data.dig(*path)
    end

    def resolved_key(src)
      @resolved_key ||= unchain(:key, src)
    end

    def resolved_value(src)
      @resolved_value ||= unchain(:value, src)
    end
  end
end
