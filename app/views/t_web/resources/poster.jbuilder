json.response do
	json.(@res, :date)

	json.(@res.t_perf, :desc)
	json.theatre(@res.t_perf.theatre.name)
end
