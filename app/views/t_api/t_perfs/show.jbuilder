json.response do
	json.(@model, :id, :desc, :desc_s, :img)

	json.perf_id @model.perf_id # TODO: Delete. Why is it even here ? ThAdmin ?
	json.perf(@model.perf, :id, :name, :author)
	json.type(@model.perf.p_type, :id, :name)
	json.hall(@model.t_hall, :id, :name)
	json.actor_ids @model.actor_ids
	json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
