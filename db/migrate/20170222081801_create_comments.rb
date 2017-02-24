class CreateComments < ActiveRecord::Migration[5.0]
    def change
        create_table :comments do |t|
            t.string :author
            t.text :content
            t.integer :rating
            t.integer :status, default: 0

            t.timestamps
            t.datetime :deleted_at
        end
    end
end
