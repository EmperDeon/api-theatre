class CreateFavorites < ActiveRecord::Migration[5.0]
	def change
		create_table :favorites do |t|
			t.belongs_to :u_web, foreign_key: true
			t.integer :t_perf_id

			t.timestamps
			t.datetime :deleted_at
		end
		add_foreign_key :favorites, :t_performances, column: :t_perf_id
	end
end
