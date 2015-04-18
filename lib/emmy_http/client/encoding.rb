module EmmyHttp
  module Encoding
    extend self

    def escape(str)
      str.gsub(/([^a-zA-Z0-9_.-]+)/) { '%'+$1.unpack('H2'*$1.bytesize).join('%').upcase }
    end

    def rfc3986(str)
      str.gsub(/([!'()*]+)/m) { '%'+$1.unpack('H2'*$1.bytesize).join('%').upcase }
    end

    def www_form(enum)
      URI.encode_www_form(enum)
    end

    def query(query)
      query.map { |k, v| param(k, v) }.join('&')
    end

    def param(k, v)
      if v.is_a?(Array)
        v.map { |e| escape(k) + "[]=" + escape(e) }.join("&")
      else
        escape(k) + "=" + escape(v)
      end
    end

    #<<<
  end
end
