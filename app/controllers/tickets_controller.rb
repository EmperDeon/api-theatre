class TicketsController < ApplicationController
	def get_pdf
		t = Ticket::encode_ticket params[:id], params[:seat]

		qr = RQRCode::QRCode.new(Base64.encode64(t), :level => :l)
		qr = qr.as_png(
			resize_gte_to: false,
			resize_exactly_to: false,
			fill: 'white',
			color: 'black',
			size: 300,
		# border_modules: 1,
		# module_px_size: 2
		)
		@qr_image = Base64.encode64 qr.to_s

		logger.warn t
		@t = Ticket::decode_ticket t

		# render 'tickets/ticket', layout: false

		html = render 'tickets/ticket', layout: false

		pdf = PDFKit.new html

		pdf = pdf.to_file 'file.pdf'

		send_file 'file.pdf'
	end

	def get_qrcode
		t = Base64.encode64(Ticket::encode_ticket params[:id], params[:seat])
		qr = RQRCode::QRCode.new(t, :level => :l)
		qr = qr.as_png(
			resize_gte_to: false,
			resize_exactly_to: false,
			fill: 'white',
			color: 'black',
			size: 300,
		# border_modules: 1,
		# module_px_size: 2
		)

		file = Digest::SHA256.hexdigest(qr.to_s)
		file_n = "public/qr/#{ file }.png"

		File.open(file_n, 'wb') do |f|
			f.write(qr.to_s)
		end

		send_file File.join(Rails.root, file_n)
	end

	def get_hall_info
		p = Poster.find(params[:id])

		# Seats
		seat_state = ActiveRecord::Base.send(:sanitize_sql_array, ['SELECT seat, price FROM seats WHERE poster_id = ? AND sell = 0', p.id])
		seat_state = ActiveRecord::Base.connection.execute(seat_state)

		# @seats = seat_state.each_with_object([]) { |v, o|
		# 	s = v['seat'].split('-')
		# 	o << {price: v['price'], sect: s[0], row: s[1], seat: s[2]}
		# }
		json = JSON::parse(p.t_perf.t_hall.json)

		@sectors = TicketsController::get_sectors(json, seat_state)
		@price = @sectors[:prices]
		@sectors = @sectors[:sectors]
	end

	def self.get_sectors (json, db_seats)
		sect = json['sectors'] || []
		resp = []

		seats = db_seats.collect { |v| v[0].split('-') }
		prices = Hash[db_seats.collect { |v| [v[0], v[1]] }]

		sect.each { |sect|
			pref = sect['pref']
			rs = []

			seats.select { |v| v[0] == pref }.each { |v|
				r = v[1]
				s = v[2]

				unless rs.select { |v| v[:id] == r }.count > 0
					st = seats.select { |v| v[0] == pref && v[1] == r }.collect { |v|
						{id: v[2]}
					}

					rs << {id: r, seats: st}
				end
			}

			resp << {id: pref, name: sect['name'], rows: rs}
		}

		{sectors: resp, prices: prices}
	end
end
