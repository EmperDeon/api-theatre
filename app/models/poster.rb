class Poster < ApplicationRecord
    #
    # Relations
    #
    belongs_to :t_perf, class_name: 'TPerformance'
    belongs_to :t_hall


    #
    # Scopes
    # TODO: Rewrite without 'then'
    scope :closest, -> (count) { order(id: :desc).limit(count).includes(:t_hall, :t_perf) if count } # For index

    scope :by_month, -> (month) { where('MONTH(date) = ?', month) if month }
    scope :by_day, -> (day) { where('DAYOFWEEK(date) = ?', day) if day }
    scope :by_time, -> (time) { where('DATE_FORMAT(date, \'%H:%i\') = ?', get_time(time)) if time }

    scope :by_type, -> (id) { where(t_perf_id: TPerformance::by_type(id)) if id }
    scope :by_name, -> (id) { where(t_perf_id: TPerformance::by_name(id)) if id }
    scope :by_theatre, -> (id) { where(t_perf_id: TPerformance::by_theatre(id)) if id }

    def self.get_time(time)
        a = UtilsHelper.get_hash('time')

        a[time.to_i]
    end
end
