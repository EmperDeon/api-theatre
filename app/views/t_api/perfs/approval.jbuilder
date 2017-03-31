json.response @models do |m|
	json.(m, :id, :name, :author, :updated_at)
	json.p_type m.p_type_id
	json.theatre @theatres[m.approved - 1].name
	json.theatre_id @theatres[m.approved - 1].id
end
