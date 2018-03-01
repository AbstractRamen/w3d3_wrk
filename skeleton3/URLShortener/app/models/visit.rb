class Visit < ApplicationRecord

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :surl_id,
    class_name: :ShortenedUrl

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User



  def self.record_visit!(user, shortened_url)
    Visit.create!(user_id: user.id, surl_id: shortened_url.id)
  end

end
