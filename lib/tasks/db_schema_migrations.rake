namespace :db do
  desc "Prints the migrated versions"

task :schema_migrations => :environment do
  puts ActiveRecord::Base.connection.select_values(
           'select version from schema_migration order by version')
  end

end


