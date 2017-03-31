json.response @res do |m|
	json.(m, :id, :img)

	json.(m.perf, :id, :name, :author)
end