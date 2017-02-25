class CreateJoinTableTPerfsActors < ActiveRecord::Migration[5.0]
    def change
        create_join_table :t_performances, :actors do |t|
            t.index %w(t_performance_id actor_id), :unique => true
        end
    end
end
