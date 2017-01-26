class CreateArticles < ActiveRecord::Migration[5.0]
    def change
        create_table :articles do |t|
            t.integer :theatre_id

            t.string :name
            t.string :img
            t.text :desc
            t.text :desc_s

            t.timestamps
            t.datetime :deleted_at
        end

        add_foreign_key :articles, :theatres
    end
end
