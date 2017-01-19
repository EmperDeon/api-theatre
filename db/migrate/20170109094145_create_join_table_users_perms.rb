class CreateJoinTableUsersPerms < ActiveRecord::Migration[5.0]
    def change
        create_join_table :u_apis, :u_perms do |t|
            # t.index [:u_api_id, :u_perm_id]
            # t.index [:u_perm_id, :u_api_id]
        end
    end
end
