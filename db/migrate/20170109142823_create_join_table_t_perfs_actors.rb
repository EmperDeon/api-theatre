class CreateJoinTableTPerfsActors < ActiveRecord::Migration[5.0]
    def change
        create_join_table :t_performances, :actors do |t|

        end
    end
end
