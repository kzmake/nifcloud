class Nifcloud::Client
  module Keys
    def CreateKeyPair(options={})
      options[:Action] = 'CreateKeyPair'
      get('/', query: options)
    end

    def DeleteKeyPair(options={})
      options[:Action] = 'DeleteKeyPair'
      get('/', query: options)
    end
  end
end
