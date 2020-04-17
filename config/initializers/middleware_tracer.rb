module MiddlewareTracer
  def call(env)
    # request = ActionDispatch::Request.new(env)
    puts "-> #{self.class.name}:"
    status, headers, response = super(env)
    puts "<- #{self.class.name}, Status: #{status}"
    [status, headers, response]
  end
end

# Instrument the middleware stack after initialization so that we
# know the stack won't be changed afterwards.
Rails.configuration.after_initialize do
  Rails.application.middleware.each do |middleware|
    klass = middleware.klass

    # There are a few odd middlewares that aren't classes.
    klass.prepend(MiddlewareTracer) if klass.respond_to?(:prepend)
  end
end
