json.response @res do |m|
	json.(m, :id, :date)

	json.(m.t_perf, :img)
	json.(m.t_perf.perf, :name)
	json.theatre(m.t_perf.theatre.name)

end