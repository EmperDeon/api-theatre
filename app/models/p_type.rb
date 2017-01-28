class PType < ResourceRecord
    has_many :perfs, class_name: 'Performance', inverse_of: :p_type
end
