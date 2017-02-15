class Performance < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:name, :author, :p_type_id]

    #
    # Relation
    #
    belongs_to :p_type
    has_many :t_perfs, class_name: 'TPerformance', inverse_of: :perf


    #
    # Scopes
    #

    # Return rows, where approved column equal 0 or theatre_id
    #
    scope :only_approved, -> (user) {
        r = [0]

        r << user.theatre_id if (user && user.theatre_id != 0)

        where(approved: r)
    }


    #
    # Validations
    #
    validates :name, :author, presence: true, length: {in: 5..255}
    validates :p_type, presence: true
    validates :name, uniqueness: true
end
