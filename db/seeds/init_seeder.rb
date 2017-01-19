# Set local MySQL increments to ClearDB's
#

if Rails.env == 'development'
    # exec_sql 'SET @@global.auto_increment_increment = 10'
    # exec_sql 'SET @@global.auto_increment_offset = 4'
    # exec_sql 'SET @@session.auto_increment_increment = 10'
    # exec_sql 'SET @@session.auto_increment_offset = 4'
end