module Backends
  class Fake
    def initialize(address, port=80)
      @address, @port = address, port
    end

    def get(uri_path, *args, &block)
      do_request(:get, uri_path, *args, &block)
    end

    def post(uri_path, *args, &block)
      do_request(:post, uri_path, *args, &block)
    end

    def put(uri_path, *args, &block)
      do_request(:put, uri_path, *args, &block)
    end

    def delete(uri_path, *args, &block)
      do_request(:delete, uri_path, *args, &block)
    end

    def do_request(method, uri_path, *args, &block)
      file_path = construct_file_path("#{method}#{uri_path}")
      unless File.exists?(file_path)
        raise "File #{file_path} doesn't exist, did you forget to stub fake data?"
      end

      json_str = nil

      File.open(file_path) { |file| json_str = file.read }

      result = JSON.parse(json_str)
      result && block_given? ? yield(result) : result
    end

    def construct_file_path(uri)
      if uri.starts_with?("/") && uri.length > 1
        uri.slice!(0)
      end
      file_path = uri.gsub(/\:\w+[^\/]/, "id").gsub("/", "_")
      file_path = "#{Rails.root}/lib/fixtures/#{@address.downcase.gsub("-", "_")}/#{file_path}.json"
    end
  end
end
