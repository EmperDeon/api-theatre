class CreateGalleries < ActiveRecord::Migration[5.0]
	def change
		create_table :galleries do |t|
			t.integer :t_perf_id
			t.string :img

			t.timestamps
			t.datetime :deleted_at
		end
		add_foreign_key :galleries, :t_performances, column: :t_perf_id
	end
end
