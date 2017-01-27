class Article < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:name, :desc, :desc_s, :img, :theatre_id]


    #
    # Relations
    #
    belongs_to :theatre


    #
    # Validations
    #
    validates :name, presence: true, length: {in: 5..255}
    validates :desc, :desc_s, {presence: true, length: {in: 5..65535}}
    # validates :img
end
