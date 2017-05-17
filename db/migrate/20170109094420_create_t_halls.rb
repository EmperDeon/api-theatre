class CreateTHalls < ActiveRecord::Migration[5.0]
    def change
        create_table :t_halls do |t|
            t.integer :theatre_id

            t.string :name
            t.text :json
            t.string :img, null: true

            t.timestamps
            t.datetime :deleted_at
        end
        add_foreign_key :t_halls, :theatres
    end
end
