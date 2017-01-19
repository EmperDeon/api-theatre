# Creates new permission
#
#   perm:: permission name
def create_u_perm(perm)
    exec_sql "INSERT INTO u_perms(perm) VALUES('#{perm}')"
end

# Creates new permissions
#
#   name:: Permission name
#   add:: Additional permissions
def create_u_perms (name, add = [])
    perms = %w(s _create _edit _delete)
    perms += add

    perms.each { |v|
        create_u_perm(name + v)
    }
end

# Gives permission to specified user
#
#   user:: User
#   perms:: Array of permission ids
def add_perms_to_user (user, perms)
    perms.each { |v|
        exec_sql "INSERT INTO u_apis_perms(u_api_id, u_perm_id) VALUES('#{user}', '#{v}')"
    }
end


create_u_perms 'theatre'
create_u_perms 'user'
create_u_perms 'actor'
create_u_perms 'perf'
create_u_perms 'poster'
create_u_perms 'article'
create_u_perms 't_perf'

create_u_perm('theatre_choose')


add_perms_to_user 1, (1..29) # Admin
add_perms_to_user 2, (5..28) # Theatre admin

add_perms_to_user 3, (13..21).to_a + (25..28).to_a # Theatre users
add_perms_to_user 4, (21..24)
