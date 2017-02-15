class CreatePerformances < ActiveRecord::Migration[5.0]
    def change
        create_table :performances do |t|
            t.integer :p_type_id

            t.string :name
            t.string :author

            t.integer :approved, default: 0

            t.timestamps
            t.datetime :deleted_at
        end
        add_foreign_key :performances, :p_types
    end
end
