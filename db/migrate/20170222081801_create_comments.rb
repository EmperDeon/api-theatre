class CreateComments < ActiveRecord::Migration[5.0]
    def change
        create_table :comments do |t|
	        t.belongs_to :u_web, foreign_key: true
            t.text :content
            t.integer :rating
            t.integer :status, default: 0

            t.timestamps
            t.datetime :deleted_at
        end
    end
end
