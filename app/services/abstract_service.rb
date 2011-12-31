class AbstractService
  def initialize(backend_class)
    @backend_client = backend_class.new(address, port)
  end

  def address
    raise "There is no domain for AbstractService"
  end

  def port
    80
  end

  protected

  def get(uri_path, *args, &block)
    make_request(__method__, uri_path, *args, &block)
  end

  def post(uri_path, *args, &block)
    make_request(__method__, uri_path, *args, &block)
  end

  def put(uri_path, *args, &block)
    make_request(__method__, uri_path, *args, &block)
  end

  def delete(uri_path, *args, &block)
    make_request(__method__, uri_path, *args, &block)
  end

  private

  def validate_uri_path!(path)
    raise "uri_path must start with a '/'" unless path.starts_with?("/")
    raise "Invalid characters '?' or '&' in the uri_path" unless path.scan(/\?|\&/).empty?
  end

  def make_request(http_method_type, uri_path, *args, &block)
    validate_uri_path!(uri_path)
    @backend_client.send(http_method_type, uri_path, *(args.compact), &block)
  end
end
