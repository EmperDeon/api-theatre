class Poster < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:t_perf_id, :t_hall_id, :date]

    #
    # Relations
    #
    belongs_to :t_perf, class_name: 'TPerformance'
    belongs_to :t_hall


    #
    # Validations
    #
    validate :check_uniqueness
    validates :t_perf, :t_hall, :date, presence: true


    #
    # Scopes
    # TODO: Rewrite without 'then'
    scope :by_month, -> (month) { where('MONTH(date) = ?', month) if month }
    scope :by_day, -> (day) { where('DAYOFWEEK(date) = ?', day) if day }
    scope :by_time, -> (time) { where('DATE_FORMAT(date, \'%H:%i\') = ?', get_time(time)) if time }

    scope :by_type, -> (id) { where(t_perf_id: TPerformance::by_type(id)) if id }
    scope :by_name, -> (id) { where(t_perf_id: TPerformance::by_name(id)) if id }
    scope :by_theatre, -> (id) { where(t_perf_id: TPerformance::by_theatre(id)) if id }
    scope :by_user, -> (id) { by_theatre(id) }


    def self.get_time(time)
        a = UtilsHelper.get_hash('time')

        a[time.to_i]
    end

    private
    def check_uniqueness
        p = Poster.where('t_perf_id = ? AND t_hall_id = ? AND date = ?', t_perf_id, t_hall_id, date)
        if p.count > 0
            errors.add(:t_perf_id, ' needs to be unique')
        end
    end
end
