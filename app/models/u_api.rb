class UApi < ApplicationRecord
    has_secure_password

    #
    # Relations
    #
    has_and_belongs_to_many :u_perms, through: :u_api_perms


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
