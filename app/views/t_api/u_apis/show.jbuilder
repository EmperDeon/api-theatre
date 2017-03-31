json.response do
	json.(@model, :id, :fio, :login, :tel_num, :position, :theatre_id)

	json.perms @model.u_perm_ids

	json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end