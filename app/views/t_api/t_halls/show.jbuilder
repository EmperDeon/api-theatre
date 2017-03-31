json.response do
	json.(@model, :id, :name, :json)

	json.timestamps(@model, :created_at, :updated_at, :deleted_at)
end