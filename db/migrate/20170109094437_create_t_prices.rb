class CreateTPrices < ActiveRecord::Migration[5.0]
	def change
		create_table :t_prices do |t|
			t.belongs_to :poster, foreign_key: true
			t.belongs_to :t_hall, foreign_key: true

			t.text :json

			t.timestamps
			t.datetime :deleted_at
		end
	end
end
