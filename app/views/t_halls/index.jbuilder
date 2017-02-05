json.response @models do |m|


    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end