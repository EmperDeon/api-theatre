class ResourceRecord < ApplicationRecord
	self.abstract_class = true
	acts_as_paranoid

	#
	# Scopes
	#

	# If user is not null AND If user.theatre_id != 0
	#  display rows only from same theatre
	#
	# user:: User model
	scope :by_user, -> (user = nil) {
		if user && user.theatre_id != 0
			where(theatre_id: user.theatre_id)
		end
	}

	# Get count rows from model
	#
	# count:: rows count
	scope :closest, -> (count) {
		if count
			order(id: :desc)
				.limit(count)
		end
	}

	# Get rows, that updated since stamp
	#
	# stamp:: time stamp
	scope :updated_since, -> (stamp) {
		if stamp
			where(updated_at: (stamp..Time.now))
		end
	}
end
