class UPerm < ApplicationRecord
    validates :perm, uniqueness: true
end
