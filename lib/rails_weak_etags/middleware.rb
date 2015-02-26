module RailsWeakEtags
  # http://stackoverflow.com/questions/18693718/weak-etags-in-rails
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = nil, nil, nil

      # make request etags "strong" before calling the app.  Restore the original
      # header before passing control back.  Rack 1.6 added weak e-tag support
      # for digest bodies, so it needs to see the weak etag.
      request_etag = env['HTTP_IF_NONE_MATCH']
      if request_etag && request_etag =~ /^W\//
        env['HTTP_IF_NONE_MATCH'] = request_etag[2..-1]
        status, headers, body = @app.call(env)
        env['HTTP_IF_NONE_MATCH'] = request_etag
      else
        status, headers, body = @app.call(env)
      end

      # make all response etags "weak"
      response_etag = headers['ETag']
      if response_etag && response_etag !~ /^W\//
        headers['ETag'] = "W/#{response_etag}"
      end

      [status, headers, body]
    end
  end
end
