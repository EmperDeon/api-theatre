json.response do
	json.(@res, :id, :desc, :desc_s, :img)

	json.perf_id @res.perf_id # TODO: Delete. Why is it even here ? ThAdmin ?
	json.perf(@res.perf, :id, :name, :author)
	json.type(@res.perf.p_type, :id, :name)
	json.hall(@res.t_hall, :id, :name)

	json.timestamps(@res, :created_at, :updated_at, :deleted_at)
end
