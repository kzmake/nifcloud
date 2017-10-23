class Nifcloud::Client
  module Volumes
    def AttachVolume(options={})
      options[:Action] = 'AttachVolume'
      get('/', query: options)
    end
  end
end
