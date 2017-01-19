class THall < ApplicationRecord
    belongs_to :theatre

    has_many :t_perfs, class_name: 'TPerformance'

end
