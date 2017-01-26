class CreateActors < ActiveRecord::Migration[5.0]
    def change
        create_table :actors do |t|
            t.integer :theatre_id

            t.string :name
            t.text :desc
            t.string :img

            t.timestamps
            t.datetime :deleted_at
        end
        add_foreign_key :actors, :theatres
    end
end
