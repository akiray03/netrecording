module Netrecording
  module NetHTTP
    def self.extended(base) #:nodoc:
      base.class_eval do
        alias :alias_for_request :request

        # request is overridden and the request and response are stored as a hash that can be written to a cache file
        def request(req, body = nil, &block)
          response = alias_for_request(req, body)

          unless NetRecording.recording?
            yield response and return if block
            return response
          end

          path = "http://#{req.bauth if req.bauth}#{req['host']}#{req.path}"
          NetRecording.records << { method: req.method, path: path, request: req, response: response }

          yield response if block
          response
        end
      end
    end
  end
end
