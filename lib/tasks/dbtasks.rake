require 'rake'

namespace :db do
    desc 'Refresh and seed DB'
    task :redo do
        # Rake::Task['db:drop'].invoke
        Rake::Task['db:create'].invoke
        Rake::Task['db:migrate'].invoke
        Rake::Task['db:seed'].invoke
    end

end
