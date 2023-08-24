class Movie < ApplicationRecord
  belongs_to :director
  include PgSearch::Model
  multisearchable against: [:title, :synopsis]
  pg_search_scope :search_by_title_and_synopsis_and_year,
    against: [ :title, :synopsis, :year ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  pg_search_scope :global_search,
  against: [ :title, :synopsis ],
  associated_against: {
    director: [ :first_name, :last_name ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
