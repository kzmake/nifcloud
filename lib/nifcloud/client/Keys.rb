class Nifcloud::Client
  module Keys
    def CreateKeyPair(options={})
      options[:Action] = 'CreateKeyPair'
      get('/', query: options)
    end
  end
end
