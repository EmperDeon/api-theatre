class UtilsController < ApplicationController
    # before_action :check_api_token

    # Allowed lists
    A_LISTS = %w(articles posters performances theatres p_types t_performances t_halls u_apis u_perms)
    A_HASHES = %w(articles posters performances theatres p_types t_performances t_halls u_apis u_perms)

    # Easy to access tables (table has id and name columns)
    E_LISTS_C = %w(articles performances theatres p_types t_halls)

    # Tables, with column theatre_id
    T_LISTS = %w(t_halls t_performances articles actors u_apis)

    def lists
        res get_hash params[:name]
    end

    # noinspection RailsChecklist01
    def updates
        stamp = Time.at(params[:stamp].to_i ||= 0)

        @articles = Article.updated_since(stamp).includes(:theatre)
        @posters = Poster.updated_since(stamp).includes(:t_perf)
        @p_types = PType.updated_since(stamp)
        @theatres = Theatre.updated_since(stamp).includes(:t_perfs)
    end

    def root
        res 'This is an API server for Theatres App'
    end

    def upload
        image = params[:img]
        preview = params[:preview]

        if image.content_type == 'image/png'
            file_d = image.read

            # file name for original img
            file = Digest::SHA256.hexdigest(file_d)
            file_n = "public/img/#{ file }"

            # file name for preview
            file_p = file_n + '-p.png'

            if File.exist? file_p
                # if that's same file (checksums are equal)

            else
                File.open(file_n + '.png', 'wb') do |f|
                    f.write(file_d)
                end

                File.open(file_p, 'wb') do |f|
                    f.write(preview.read)
                end
            end
        end

        res file
    end

    def preview
        path = params[:url] || ''
        path.gsub!(/\./, '_')
        path += '-p.png'

        path = 'public/img/' + path

        if File.exist? (path)
            res Base64.encode64 File.binread(path)

        else
            # err 'no_file', 'No such file', 404
            res ''
        end
    end

    #
    # Utils helper functions
    #

    #
    # Get list of pairs <id, name>
    #  Needed by API(TComboBox)
    #
    def get_list(type)
        allowed_tables = A_LISTS

        if allowed_tables.include? type
            sql = 'SELECT '

            # Field names
            sql += get_fields(type)

            # Table names
            sql += get_tables(type)

            # Conditions
            sql += get_conditions(type)

            PType.find_by_sql(sql)

        else
            # TODO: Log error
        end
    end


    #
    # Get hash of pairs <id, name>
    #  Needed by TPerformanceHelper
    #
    def get_hash(type)
        allowed_tables = A_HASHES
        allowed_tran = %w(month day)
        allowed_spec = %w(time)

        if allowed_tables.include? type
            rows = get_list (type)
            r = {}

            rows.each { |v|
                r[v.id] = v.name
            }

            r

        elsif allowed_tran.include? type
            a = ::I18n.t("g_#{type}s").clone # Because Translation is given by reference. REFERENCE.

            i = 0
            a.map! { |v| [i += 1, v] }

            a.to_h

        elsif allowed_spec.include? type
            get_special_list type

        else
            # TODO: Log error
        end
    end


    #
    # Lists for 'special' or 'unique' types
    #  TODO: move map to Array class
    #
    #  type:: list type
    def get_special_list(type)
        a = []

        q = if Rails.env.production?
                "DATE_FORMAT(date, '%H:%i')"
            else
                "strftime('%H:%M', date)"
            end

        if type == 'time'
            a = ActiveRecord::Base.connection.execute(
                "SELECT DISTINCT #{q} AS 'time' FROM posters"
            ).to_a

            a.map! { |v| v[0] }
        end

        i = 0
        a.map! { |v| [i+= 1, v] }

        a.to_h
    end


    #
    # Get field names
    #
    def get_fields(type)
        sql = ''

        if E_LISTS_C.include? type # Is easy to use ?
            sql += 'id, name'

        elsif type == 'u_apis' # For users
            sql += 'id, fio AS name'

        elsif type == 'u_perms' # For users
            sql += 'id, perm AS name'

        elsif type == 't_performances'
            sql += 't.id, p.name';

        elsif type == 'posters' # Unique
            if Rails.env.production?
                sql += "r.id, CONCAT(p.name,' - ',DATE_FORMAT(date, '%d-%m-%Y %H:%i'),' - ',h.name) AS name"
            else
                sql += "r.id, (strftime('%d-%m-%Y %H:%M', date) || ' - ' || p.name || ' - ' || h.name) AS name"
            end
        end

        sql
    end

    #
    # Get table name
    #
    def get_tables(type)
        sql = ' FROM '

        if type == 'posters'
            sql += 'posters AS r
  JOIN t_performances AS t ON r.t_perf_id=t.id
  JOIN performances AS p ON t.perf_id=p.id
  JOIN t_halls AS h ON t.t_hall_id=h.id'

        elsif type == 't_performances'
            sql += 't_performances AS t JOIN performances AS p ON t.perf_id=p.id';

        else
            sql += type
        end

        sql
    end

    #
    # Get conditions if needed
    #
    def get_conditions(type)
        sql = ' WHERE '

        if T_LISTS.include? type
            # check_api_token

            if @current_user && @current_user.theatre_id != 0
                sql += 'theatre_id = ' + @current_user.theatre_id.to_s
            end

        elsif type == 'u_perms'
            sql += "perm NOT LIKE 'theatres%'"
        end

        sql == ' WHERE ' ? '' : sql
    end
end
