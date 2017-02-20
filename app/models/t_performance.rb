class TPerformance < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:desc, :desc_s, :img, :perf_id, :theatre_id, :t_hall_id]

    #
    # Relations
    #
    belongs_to :theatre
    belongs_to :t_hall
    belongs_to :perf, class_name: 'Performance'

    has_many :posters, foreign_key: 't_perf_id', inverse_of: :t_perf, dependent: :destroy


    #
    # Validations
    #
    validates :img, presence: true, length: {in: 5..255}
    validates :desc, :desc_s, presence: true, length: {in: 5..65535}
    validates :perf, :t_hall, presence: true # Relations validation


    #
    # Scopes
    #
    scope :by_theatre, -> (id) { where(:theatre_id => id) if id } # TODO Already exists

    scope :by_type, -> (id) { joins(:perf).where(performances: {type_id: id}) if id }
    scope :by_name, -> (id) { where(perf_id: id) if id }


    #
    # Helper methods
    #
    def self.get_setting_vals (id)
        p = self.find(id)
        type = p.perf.type_id
        name = p.perf_id
        theatre = p.theatre_id

        #
        r = {}
        r['type'] = type
        r['name'] = name
        r['theatre'] = theatre

        r
    end
end
