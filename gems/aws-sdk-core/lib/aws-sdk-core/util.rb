require 'cgi'

module Aws
  # @api private
  module Util
    class << self

      def deep_merge(left, right)
        case left
        when Hash then left.merge(right) { |key, v1, v2| deep_merge(v1, v2) }
        when Array then right + left
        else right
        end
      end

      def copy_hash(hash)
        if Hash === hash
          deep_copy(hash)
        else
          raise ArgumentError, "expected hash, got `#{hash.class}`"
        end
      end

      def deep_copy(obj)
        case obj
        when Hash
          obj.inject({}) do |h, (k,v)|
            h[k] = deep_copy(v)
            h
          end
        when Array
          obj.map { |v| deep_copy(v) }
        else
          v
        end
      end
    end
  end
end