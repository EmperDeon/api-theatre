class Ticket < ApplicationRecord
	#
	# Relations
	#
	belongs_to :u_web
	belongs_to :poster

	#
	# Utility methods
	#
	def self.get_params (poster, seat)
		poster = Poster.find poster
		seat = seat.split '-'

		{
			poster_id: poster.id,
			poster_date: poster.date,
			poster_name: poster.t_perf.perf.name,
			# poster_genre: poster.t_perf.perf.p_type.name,

			theatre: poster.t_perf.theatre.name,
			theatre_hall: poster.t_perf.t_hall.name,
			buy_date: Time.now,

			seat_sector: seat[0],
			seat_row: seat[1],
			seat_seat: seat[2]
		}
	end

	def self.encode_ticket (poster, seat)
		# crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
		# crypt.encrypt_and_sign(get_params poster, seat)
		r = JSON.unparse get_params(poster, seat)
		Zlib::Deflate.deflate r
	end

	def self.decode_ticket (ticket)
		# crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
		# crypt.decrypt_and_verify(ticket)
		r = Zlib::Inflate.inflate ticket
		JSON.parse r
	end

	def self.generate_ticket_page (ticket)

	end
end
