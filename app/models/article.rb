class Article < ApplicationRecord
    #
    # Relations
    #
    belongs_to :theatre


    #
    # Scopes
    #
    scope :closest, -> (count) { order(id: :desc).limit(count) if count } # For index
end
