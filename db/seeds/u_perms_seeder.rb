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
def create_res_perms (name, add = [])
    perms = %w(_edit) + add

    create_u_perm(name)
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

# Global Admin
create_u_perm('theatre_choose') # 1
create_u_perm('perfs_approve') # 2
create_res_perms 'theatres' # 3, 4

# Theatre admin
create_res_perms 'u_apis' # 5, 6

# Theatre users
create_res_perms 'actors' # 7, 8
create_res_perms 'perfs' # 9, 10
create_res_perms 'posters' # 11, 12
create_res_perms 'articles' # 13, 14
create_res_perms 't_perfs' # 15, 16
create_res_perms 't_halls' # 17, 18
create_res_perms 't_prices' # 19, 20


add_perms_to_user 1, (1..20) # Admin
add_perms_to_user 2, (5..20) # Theatre admin
add_perms_to_user 5, (5..20) # Theatre admin

add_perms_to_user 3, (7..12).to_a + (15..20).to_a # Theatre users
add_perms_to_user 4, (13..15)
