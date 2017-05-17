class CreateUWebs < ActiveRecord::Migration[5.0]
    def change
        create_table :u_webs do |t|
	        ## Database authenticatable
	        t.string :login, null: false, default: ''
	        t.string :encrypted_password, null: false, default: ''

	        ## Rememberable
	        t.datetime :remember_created_at

	        t.string :fio
	        t.string :tel_num

	        t.timestamps null: false
	        t.datetime :deleted_at

	        # ## Recoverable
	        # t.string   :reset_password_token
	        # t.datetime :reset_password_sent_at

	        # ## Trackable
	        # t.integer  :sign_in_count, default: 0, null: false
	        # t.datetime :current_sign_in_at
	        # t.datetime :last_sign_in_at
	        # t.string   :current_sign_in_ip
	        # t.string   :last_sign_in_ip
        end

        add_index :u_webs, :login, unique: true
	    # add_index :u_webs, :reset_password_token, unique: true
    end
end
