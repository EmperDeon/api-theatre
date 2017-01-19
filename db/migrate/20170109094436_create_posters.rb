class CreatePosters < ActiveRecord::Migration[5.0]
    def change
        create_table :posters do |t|
            t.integer :t_perf_id
            t.integer :t_hall_id

            t.datetime :date

            t.timestamps
        end
        add_foreign_key :posters, :t_performances, column: :t_perf_id
        add_foreign_key :posters, :t_halls
    end
end
