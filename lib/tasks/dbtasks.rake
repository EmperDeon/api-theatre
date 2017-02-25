require 'rake'

# Run rake task
#  ::task Task name
#  ::env Environment
#
def run_rake_db_task (task, env)
    t1 = Time.now
    system("rake db:#{ task } RAILS_ENV=#{ env } VERBOSE=false")
    t2 = Time.now

    puts "#{ task.capitalize } on #{ env.capitalize } env ended in #{ (t2 - t1).to_s }s"
end

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

            run_rake_db_task 'create', 'development'
            run_rake_db_task 'migrate', 'development'
            run_rake_db_task 'migrate', 'test'
            run_rake_db_task 'seed', 'development'

        elsif Rails.env.production?
            Rake::Task['db:drop'].invoke
            Rake::Task['db:create'].invoke

            puts 'Migrating Prod env'
            system('rake db:migrate RAILS_ENV=production VERBOSE=false')

            puts 'Seeding Prod env'
            system('rake db:seed RAILS_ENV=production VERBOSE=false')
        end
    end

end
