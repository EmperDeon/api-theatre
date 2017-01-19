class CreateUApis < ActiveRecord::Migration[5.0]
    def change
        create_table :u_apis do |t|
            t.integer :theatre_id

            t.string :login
            t.string :password_digest

            t.string :fio
            t.string :tel_num
            t.string :position

            t.timestamps

        end
        add_foreign_key :u_apis, :theatres
    end
end
