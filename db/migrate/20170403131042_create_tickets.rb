class CreateTickets < ActiveRecord::Migration[5.0]
	def change
		create_table :tickets do |t|
			t.belongs_to :u_api, foreign_key: true
			t.belongs_to :poster, foreign_key: true
			t.string :ticket

			t.timestamps
		end
	end
end
