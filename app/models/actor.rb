class Actor < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:name, :desc, :img, :theatre_id]


    #
    # Relations
    #
    belongs_to :theatre


    #
    # Validations
    #
    validates :name, :img, presence: true, length: {in: 5..255}
    validates :desc, presence: true, length: {in: 5..65535}

end
