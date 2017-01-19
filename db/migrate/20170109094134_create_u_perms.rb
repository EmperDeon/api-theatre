class CreateUPerms < ActiveRecord::Migration[5.0]
    def change
        create_table :u_perms do |t|
            t.string :perm
        end

    end
end
