json.response do
	json.(@model, :desc, :tel_num, :id, :name, :img, :address)
	json.t_halls @model.t_halls, :id, :name

	json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end