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
    
    def DescribeKeyPairs(options={})
      options[:Action] = 'DescribeKeyPairs'
      get('/', query: options)
    end

    def NiftyModifyKeyPairAttribute(options={})
      options[:Action] = 'NiftyModifyKeyPairAttribute'
      get('/', query: options)
    end
    
    def ImportKeyPair(options={})
      options[:Action] = 'ImportKeyPair'
      get('/', query: options)
    end
  end
end
