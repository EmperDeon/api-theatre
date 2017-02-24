class Comment < ApplicationRecord
    acts_as_paranoid

    validates :author, :content, :rating, presence: true
    validates :content, length: {in: 5..65535}
    validate :check_author

    def author
        a = self[:author]

        ai = a.to_i
        puts ai

        if ai != 0
            UWeb.find(ai).fio
        else
            a
        end
    end

    private
    def check_author
        a = author
        ai = a.to_i
        if ai != '0' && ai.to_s == a
            unless UWeb.exists? ai
                errors.add(:author, " doesn't exist")
            end
        else
            if a.length < 5 || a.length > 65535
                errors.add(:author, ' length needs to be in 5..65535 range')
            end
        end
    end

end
