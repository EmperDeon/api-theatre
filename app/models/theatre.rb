class Theatre < ApplicationRecord
    #
    # Scopes
    #
    has_many :t_halls
    has_many :t_perfs, class_name: 'TPerformance'


end
