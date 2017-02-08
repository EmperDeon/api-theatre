json.response @models do |m|
    json.(m, :date)

    json.perf(m.t_perf.perf, :id, :name, :author)

    json.timestamps(m, :created_at, :updated_at, :deleted_at)
end