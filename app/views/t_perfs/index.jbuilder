json.response @models do |m|
    json.(m, :id, :desc, :desc_s)

    json.perf(m.perf, :id, :name, :author)
    json.type(m.perf.p_type, :id, :name)

    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end