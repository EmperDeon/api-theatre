require 'rake'

namespace :db do
    desc 'Refresh and seed DB'
    task :redo do
        if Rails.env.development?
            if File.exist? 'D:/Programming/Theatre_Run/db.sqlite3'
                File.delete('D:/Programming/Theatre_Run/db.sqlite3')
            end
            if File.exist? 'D:/Programming/Theatre_Run/db_test.sqlite3'
                File.delete('D:/Programming/Theatre_Run/db_test.sqlite3')
            end

            system('rake db:create RAILS_ENV=development')
            system('rake db:migrate RAILS_ENV=development')
            system('rake db:seed RAILS_ENV=development')

            system('rake db:migrate RAILS_ENV=test')

        elsif Rails.env.production?
            Rake::Task['db:drop'].invoke
            Rake::Task['db:create'].invoke
            Rake::Task['db:migrate'].invoke
            Rake::Task['db:seed'].invoke
        end
    end

end
