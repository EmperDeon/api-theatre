# Load and execute seeder code
#
#  name:: Filename to load
def load_seed (name)
    require File.join(Rails.root, 'db', 'seeds', name + '_seeder')
end


# Execute custom SQL code
#
#  sql:: SQL string
def exec_sql (sql)
    ActiveRecord::Base.connection.execute sql
end


load_seed 'init'
load_seed 'theatres'
load_seed 'u_perms'
load_seed 'u_apis'
load_seed 'u_webs'
load_seed 'actors'
load_seed 'p_types'
load_seed 'perf'
load_seed 't_hall'
load_seed 't_perf'
load_seed 'poster'
load_seed 'articles'


