json.response @res do |m|
	json.(m, :id, :name, :img, :address)
end
