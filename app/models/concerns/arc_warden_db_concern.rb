module ArcWardenDbConcern
  extend ActiveSupport::Concern

  included do
    AW_DB = YAML.load_file(File.join(Rails.root, "config", "database_aw.yml"))[Rails.env.to_s]
    establish_connection AW_DB
  end
end
