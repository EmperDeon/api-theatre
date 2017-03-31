class ActiveSupport::TimeWithZone
	def as_json(options = {})
		strftime('%d-%m-%Y %H:%M')
	end
end