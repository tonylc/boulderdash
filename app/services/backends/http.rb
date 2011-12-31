module Backends
  class Http
    def initialize(address, port)
      @address, @port = address, port
    end

    def get(uri_path, *args, &block)
      options = args.extract_options!
      set_ignore_codes!(options)
      uri_path = create_uri(uri_path, *args)

      uri_path << "?" + options.map {|k,v| "#{k}=#{v}"}.join("&") if options.present?

      request = Net::HTTP::Get.new(uri_path)
      make_request!(request, options, &block)
    end

    def post(uri_path, *args, &block)
      options = args.extract_options!
      set_ignore_codes!(options)
      uri_path = create_uri(uri_path, *args)

      request = Net::HTTP::Post.new(uri_path)
      request.set_form_data(options) if options.present?

      make_request!(request, options, &block)
    end

    def put(uri_path, *args, &block)
      options = args.extract_options!
      set_ignore_codes!(options)
      uri_path = create_uri(uri_path, *args)

      request = Net::HTTP::Put.new(uri_path)
      request.set_form_data(options) if options.present?

      make_request!(request, options, &block)
    end

    def delete(uri_path, *args, &block)
      options = args.extract_options!
      set_ignore_codes!(options)
      uri_path = create_uri(uri_path, *args)

      request = Net::HTTP::Delete.new(uri_path)

      make_request!(request, options, &block)
    end

    private

    def set_ignore_codes!(options)
      @ignored_codes = (options.present? && options.delete(:ignore_codes)) || []
    end

    def make_request!(request, options, &block)
      http = Net::HTTP.new(@address, @port)
      resp = http.request(request)
      resp_code = resp.code.to_i

      if resp_code != 200 && !@ignored_codes.include?(resp_code)
        raise "WTF non 200...how do we want to deal w/ this?"
      end

      result = JSON.parse(resp.body)
      result && block_given? ? yield(result) : result
    end

    def create_uri(uri_path, *args)
      uri_path.gsub(/\:\w+[^\/]/) {|path| args.shift }
    end
  end
end
