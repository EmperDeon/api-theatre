class Performance < ApplicationRecord
    belongs_to :p_type

    has_many :t_perfs, class_name: 'TPerformance'
end
