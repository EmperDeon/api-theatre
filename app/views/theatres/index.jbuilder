json.response @models do |m|
    json.(m, :id, :name, :img, :desc, :address, :tel_num)

    json.t_halls m.t_halls, :id, :name

    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end
