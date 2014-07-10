module RailsWeakEtags
  class Railtie < ::Rails::Railtie
    initializer "rails_weak_etags.configure_rails_initialization" do |app|
      app.middleware.insert_before(Rack::ConditionalGet, RailsWeakEtags::Middleware)
    end
  end
end
