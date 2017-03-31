class TPrice < ResourceRecord
	# Allowed for mass-assignment fields. For get_params in ResourceController
	FILLABLE = [:poster_id, :t_hall_id, :json]

	#
	# Relations
	#
	belongs_to :poster
	belongs_to :t_hall


	#
	# Validations
	#

end
