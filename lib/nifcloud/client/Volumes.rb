class Nifcloud::Client
  module Instances
    def AttachVolume(options={})
      options[:Action] = 'AttachVolume'
      get('/', query: options)
    end
  end
end
