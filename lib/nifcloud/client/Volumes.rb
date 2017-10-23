class Nifcloud::Client
  module Volumes
    def AttachVolume(options={})
      options[:Action] = 'AttachVolume'
      get('/', query: options)
    end

    def CreateVolume(options={})
      options[:Action] = 'CreateVolume'
      get('/', query: options)
    end

    def DeleteVolume(options={})
      options[:Action] = 'DeleteVolume'
      get('/', query: options)
    end
  end
end
