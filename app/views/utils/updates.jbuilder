json.response do

    # For next requests
    json.timestamp Time.now.to_i

    json.articles @articles do |a|
        json.(a, :name, :desc, :img)
        json.date a.updated_at
        json.theatre_name a.theatre.name
    end

    json.posters @posters do |p|
        json.(p, :date)
        json.(p.t_perf, :desc)
        json.img (ENV['API_SERVER_PATH'] + 'img/' + p.t_perf.img + '.png')
        json.(p.t_perf.perf, :author, :name, :p_type_id)
        json.theatre_name p.t_perf.theatre.name
        json.hall_name p.t_perf.t_hall.name
    end

    json.p_types @p_types do |p|
        json.(p, :name)
    end

    json.theatres @theatres do |a|
        json.(a, :name, :desc, :img)
        json.t_perfs a.t_perfs do |p|
            json.(p.perf, :author, :name, :p_type_id)
            json.(p, :desc, :img)
            json.hall_name p.t_hall.name
        end
    end

end
