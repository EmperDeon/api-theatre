class CreatePerformances < ActiveRecord::Migration[5.0]
    def change
        create_table :performances do |t|
            t.integer :type_id

            t.string :name
            t.string :author

            t.timestamps
        end
        add_foreign_key :performances, :p_types, column: :type_id
    end
end
