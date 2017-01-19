class TPerformance < ApplicationRecord
    #
    # Relations
    #
    belongs_to :theatre
    belongs_to :perf, class_name: 'Performance'

    has_many :posters, foreign_key: 't_perf_id'


    #
    # Scopes
    #
    scope :by_theatre, -> (id) { where(:theatre_id => id) }

    scope :by_type, -> (id) { joins(:perf).where(performances: {type_id: id}) if id }
    scope :by_name, -> (id) { where(perf_id: id) if id }
    scope :by_theatre, -> (id) { where(theatre_id: id) if id }


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
