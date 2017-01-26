class CreatePTypes < ActiveRecord::Migration[5.0]
    def change
        create_table :p_types do |t|
            t.string :name

            t.timestamps
            t.datetime :deleted_at
        end
    end
end
