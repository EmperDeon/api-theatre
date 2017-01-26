class UtilsController < ApplicationController
    # before_action :check_api_token

    def lists
        res get_hash params[:name]
    end

    # noinspection RailsChecklist01
    def updates
        stamp = Time.at(params[:stamp].to_i ||= 0)

        r = {
            articles: Article.updated_since(stamp),
            p_types: PType.updated_since(stamp),
            performances: Performance.updated_since(stamp),
            posters: Poster.updated_since(stamp),
            t_halls: THall.updated_since(stamp),
            t_performances: TPerformance.updated_since(stamp),
            theatres: Theatre.updated_since(stamp),
        }

        res r
    end


    #
    # Utils helper functions
    #

    #
    # Get list of pairs <id, name>
    #  Needed by API(TComboBox)
    #
    def get_list(type)
        allowed_tables = %w(performances theatres p_types)

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
        allowed_tables = %w(performances theatres p_types)
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

        if type == 'time'
            a = ActiveRecord::Base.connection.execute(
                'SELECT DISTINCT DATE_FORMAT(date, \'%H:%i\') AS \'time\' FROM posters'
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

        if %w(performances theatres p_types u_perms).include? type # Is easy to use ?
            sql += 'id, name'

        elsif type == 'users' # For users
            sql += 'id, fio AS name'

        elsif type == 'posters' # Unique
            sql += "r.id, CONCAT(p.name,' - ',DATE_FORMAT(date, '%d-%m-%Y %H:%i'),' - ',h.name) AS name"
        end

        sql
    end

    #
    # Get table name
    #
    def get_tables(type)
        sql = ' FROM '

        if type == 'posters'
            sql += 'FROM posters AS r
  JOIN t_performances AS t ON r.t_perf_id=t.id
  JOIN performances AS p ON t.perf_id=p.id
  JOIN t_halls AS h ON r.t_hall_id=h.id'
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


        sql == ' WHERE ' ? '' : sql
    end
end
