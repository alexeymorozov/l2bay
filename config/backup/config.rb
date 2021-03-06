# encoding: utf-8

# override all CLI paths
app_root = File.expand_path('../../..', __FILE__)
update(
  root_path:   File.expand_path('../../shared/backup/', app_root),
  config_file: __FILE__,
  log_path:    File.expand_path('log/', app_root),
  tmp_path:    File.expand_path('tmp/backup/', app_root)
)

APP_CONFIG = YAML.load(File.read(File.expand_path('config/app_config.yml', app_root)))

Backup::Database::PostgreSQL.defaults do |db|
  db.username           = "l2bay"
  db.password           = APP_CONFIG['db_password']
  db.host               = "localhost"
  db.port               = 5432
  db.additional_options = ["-xc", "-E=utf8"]
end

Dir[File.join(File.dirname(Config.config_file), "models", "*.rb")].each do |model|
  instance_eval(File.read(model))
end
