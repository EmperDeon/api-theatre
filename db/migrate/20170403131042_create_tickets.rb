class CreateTickets < ActiveRecord::Migration[5.0]
	def change
		create_table :tickets do |t|
			t.belongs_to :u_web, foreign_key: true
			t.belongs_to :seat, foreign_key: true
			t.string :ticket

			t.timestamps
		end
	end
end
