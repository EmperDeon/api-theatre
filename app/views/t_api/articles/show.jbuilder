json.response do
	json.(@model, :id, :name, :desc, :desc_s, :img)


	json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end
