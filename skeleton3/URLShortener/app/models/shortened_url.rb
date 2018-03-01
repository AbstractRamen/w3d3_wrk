require 'securerandom'

# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string           not null
#  short_url  :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ApplicationRecord

  validates :short_url, uniqueness: true, presence: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  has_many :visits,
    primary_key: :id,
    foreign_key: :surl_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  def self.random_code
    short = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: short)
      short = SecureRandom.urlsafe_base64
    end
    short
  end

  def self.create!(hash)
    h = ShortenedUrl.new(user_id: hash[:user].id, long_url: hash[:long_url], short_url: ShortenedUrl.random_code)
    h.save!
    h
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    visitors.distinct.count
  end

  def num_recent_uniques
    visitors.select do |visitor|
      visitor.created_at > 30.minutes.ago
    end .count
  end

end
