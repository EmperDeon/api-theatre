class THall < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:name, :json, :theatre_id]

    belongs_to :theatre

    has_many :t_perfs, class_name: 'TPerformance'


    validates :name, presence: true, length: {in: 5..255}

end
