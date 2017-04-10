module TApi
	class THallsController < ApiResourceController
		MODEL_CLASS = ::THall

		def index
			super

			if params[:preview] == 'true'
				@previews = {}
				@models.ids.each { |id|
					@previews[id] = get_preview_for_hall(id)
				}
			end
		end

		def create_action
			THall.create({theatre_id: @current_user.theatre_id, name: params[:name], json: params[:json]})
		end

		def get_preview_for_hall (id)
			Base64.encode64 get_image(id) #File.binread(Rails.public_path + 'none.png')
		end

		def self.get_image(id)
			json = JSON.parse(THall.find(id).json)

			w = json['width'] || 0
			h = json['height'] || 0
			cs = json['cs'] || 0

			# Create
			seat_n = [] # Seat exists
			sect_s = [] # Sector color
			sect_c = [] # Sector colors
			seat_t = [] # Seat number
			seat_r = [] # Seat row

			# Initialize with 0
			(w * h).times {
				seat_n << false
				sect_s << 0
				seat_t << 0
				seat_r << 0
			}

			# Fill seats seat_n
			json['seats'].each { |s|
				s = s.split(':')

				x = s[0].to_i
				y = s[1].to_i

				s[2].to_i.times {
					seat_n[x + y * w] = true

					x += 1
				}
			}

			json['sectors'].each { |o|
				s_id = sect_c.size + 1

				sect_c << GD2::Color::from_s(o['color'])

				o['coords'].each { |c|
					c = c.split(':')
					sect_s[c[0].to_i + c[1].to_i * w] = s_id
				}
			}

			sect_r = {}
			(0...h).each { |y|
				(0...w).each { |x|
					unless (t = sect_s[x + y * w]) == 0
						if sect_r.include? t
							if sect_r[t][1] >= x
								sect_r[t][0] += 1
							end

							sect_r[t][1] = x
						else
							sect_r[t] = [1, x]
						end

						seat_r[x + y * w] = sect_r[t][0]
					end
				}
			}

			json['seat_n'].each { |o|
				o = o.split(':')
				st = o[0].to_i
				x = o[1].to_i
				y = o[2].to_i
				lf = o[3].to_i == 1

				i = seat_n[x + y * w]
				curr_s = sect_s[x + y * w]

				while (x > -1 && x < w) && sect_s[x + y * w] == curr_s
					seat_t[x + y * w] = st
					st += 1

					x += lf ? -1 : 1

					if i == 0 || curr_s == 0
						break
					end
				end
			}

			save_image draw_image(w, h, cs, seat_n, sect_s, sect_c, seat_r, seat_t)
		end

		private
		def self.draw_image(w, h, cs, seat_n, sect_s, sect_c, seat_r, seat_t)
			i = GD2::Image::TrueColor.new(w * cs, h * cs)
			# c = GD2::Canvas.new(i)
			i.draw { |c|

				c.color = GD2::Color.new(233, 233, 233)
				c.rectangle(0, 0, w * cs, h * cs, true)

				c.font = GD2::Font::TrueType.new('public/DejaVuSans.ttf', 9)

				(0...w).each { |x|
					(0...h).each { |y|
						# Draw seats
						c.color = GD2::Color.new(175, 175, 175)
						if seat_n[x + y * w]
							draw_rect(c, cs, x, y)
						end

						# Draw sectors
						unless (s = sect_s[x + y * w]) == 0
							c.color = sect_c[s - 1]
							draw_rect(c, cs, x, y)
						end
					}
				}

				c.color = GD2::Color.new(255, 255, 255)
				(0...w).each { |x|
					(0...h).each { |y|
						# Draw row text
						unless (r = seat_r[x + y * w]) == 0
							draw_text(c, cs, x, y, r.to_s, 2, 12)
						end

						# Draw seat text
						unless (t = seat_t[x + y * w]) == 0
							draw_text(c, cs, x, y, t.to_s, 16, 28)
						end
					}
				}

			}

			i.png
		end

		def self.save_image (d)
			# file name for original img
			file = Digest::SHA256.hexdigest(d)
			file_n = "public/halls/#{ file }.png"

			File.open(file_n, 'wb') do |f|
				f.write(d)
			end

			# if Rails.env.production?
			# 	Cloudinary::Uploader.upload file_n + '.png', public_id: file
			# end

			file_n
		end

		def self.draw_rect (c, cs, x, y, f = true)
			c.rectangle(x * cs + 1, y * cs + 1, x * cs + cs - 1, y * cs + cs - 1, f)
		end

		def self.draw_text (c, cs, x, y, t, ox = 0, oy = 0)
			c.move_to(x * cs + ox, y * cs + oy)
			c.text t
		end
	end
end

class GD2::Color
	def self.from_s (s)
		s = s[1..-1]

		a = s[0..1].to_i(16)
		r = s[2..3].to_i(16)
		g = s[4..5].to_i(16)
		b = s[6..7].to_i(16)

		new(r, g, b, a)
	end
end