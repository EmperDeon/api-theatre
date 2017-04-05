class CreateSeats < ActiveRecord::Migration[5.0]
	def change
		create_table :seats do |t|
			t.belongs_to :poster, foreign_key: true

			t.string :seat
			t.float :price
			t.boolean :sell
		end
	end
end
