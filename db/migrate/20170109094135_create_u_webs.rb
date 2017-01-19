class CreateUWebs < ActiveRecord::Migration[5.0]
    def change
        create_table :u_webs do |t|
            t.string :login
            t.string :password

            t.string :fio
            t.string :tel_num

            t.timestamps
        end
    end
end
