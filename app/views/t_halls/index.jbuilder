json.response @models do |m|
    json.(m, :id)

    if @previews
        json.preview @previews[m.id]
    end

    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end