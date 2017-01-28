class UApi < ResourceRecord
    # Allowed for mass-assignment fields. For get_params in ResourceController
    FILLABLE = [:login, :password, :password_confirmation, :fio, :tel_num, :position, :theatre_id]

    has_secure_password

    #
    # Relations
    #
    has_and_belongs_to_many :u_perms, through: :u_api_perms


    #
    # Validations
    #
    validates :login, :fio, :tel_num, :position, presence: true, length: {in: 5..255}
    validates :login, uniqueness: true


    #
    # Helper methods
    #

    # Is user has specified permission ?
    #  perm:: Permission name
    def has_perm? (perm)
        self.u_perms.each { |p|
            return true if perm == p.perm
        }

        false
    end
end
