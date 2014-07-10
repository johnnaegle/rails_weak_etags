module RailsWeakEtags
  # http://stackoverflow.com/questions/18693718/weak-etags-in-rails
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      # make request etags "strong"
      etag = env['HTTP_IF_NONE_MATCH']
      if etag && etag =~ /^W\//
        env['HTTP_IF_NONE_MATCH'] = etag[2..-1]
      end

      status, headers, body = @app.call(env)

      # make response etags "weak"
      etag = headers['ETag']
      if etag && etag !~ /^W\//
        headers['ETag'] = "W/#{etag}"
      end

      [status, headers, body]
    end
  end
end
