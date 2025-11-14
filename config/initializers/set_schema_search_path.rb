# frozen_string_literal: true

# Set PostgreSQL schema search path to use docuseal schema
ActiveSupport.on_load(:active_record) do
  # Monkey patch PostgreSQL adapter to set schema search path on every connection
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.prepend(Module.new do
    def configure_connection
      super
      @connection.exec("SET search_path TO docuseal, public")
    rescue => e
      Rails.logger.warn("Could not set schema search path: #{e.message}")
    end
  end)
end
