class UWeb < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:login, :password, :password_confirmation, :fio, :tel_num, :theatre_id]

    has_secure_password

    #
    # Relations
    #
    # Comments, posts?, tickets and booking
    # has_and_belongs_to_many :u_perms, through: :u_api_perms


    #
    # Validations
    #
    validates :login, :fio, :tel_num, presence: true, length: {in: 5..255}
    validates :login, uniqueness: true

end