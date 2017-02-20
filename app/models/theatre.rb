class Theatre < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:name, :desc, :img, :address, :tel_num]

    #
    # Relations
    #
    has_many :t_halls
    has_many :t_perfs, class_name: 'TPerformance'


    #
    # Scopes
    #
    scope :by_user, -> (user = nil) {}

    #
    # Validations
    #
    validates :name, :img, :address, :tel_num, presence: true, length: {in: 5..255}
    validates :desc, {presence: true, length: {in: 5..65535}}
    validates :name, uniqueness: true
end
