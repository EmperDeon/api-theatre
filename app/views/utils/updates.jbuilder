json.response do

    json.timestamp Time.now.to_i

    if @articles
        json.articles @articles do |a|
            json.(a, :name, :desc, :img)
            json.date a.updated_at
            json.theatre_name a.theatre.name
        end
    end

    if @posters
        json.posters @posters do |p|
            json.(p, :date)
            json.(p.t_perf.perf, :author, :name, :p_type_id)
            json.(p.t_perf, :desc, :img)
            json.theatre_name p.t_perf.theatre.name
            json.hall_name p.t_perf.t_hall.name

        end
    end

    if @p_types
        json.p_types @p_types do |p|
            json.(p, :name)
        end
    end

    if @theatres
        json.theatres @theatres do |a|
            json.(a, :name, :desc, :img)
            json.t_perfs a.t_perfs do |p|
                json.(p.perf, :author, :name, :p_type_id)
                json.(p, :desc, :img)
                json.hall_name p.t_hall.name
            end
        end
    end

end