module Nifcloud
  module ObjectifiedHash
    def method_missing(meth, *args, &block)
      if args.size == 0
        obj = self[meth.to_s] || self[meth.to_sym]
        if obj.is_a?(Hash) and obj.has_key?('item')
          obj['item'].each do |i|
            i.extend ObjectifiedHash
          end
          obj['item']
        else
          obj.extend ObjectifiedHash
        end
      end
    end

    def type
      self['type']
    end

    def has?(key)
      self[key] && !self[key].to_s.empty?
    end

    def does_not_have?(key)
      self[key].nil? || self[key].to_s.empty?
    end
  end
end
