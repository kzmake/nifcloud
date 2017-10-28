class Nifcloud::Client
  module Images
    def DescribeImages(options={})
      options[:Action] = 'DescribeImages'
      get('/', query: options)
    end

    def CreateImage(options={})
      options[:Action] = 'CreateImage'
      get('/', query: options)
    end

    def DeleteImage(options={})
      options[:Action] = 'DeleteImage'
      get('/', query: options)
    end

    def ModifyImageAttribute(options={})
      options[:Action] = 'ModifyImageAttribute'
      get('/', query: options)
    end
  end
end
