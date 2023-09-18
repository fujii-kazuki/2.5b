class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorites_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索方法分岐
  def self.search_for(word, method)
    if method == 'perfect_match'
      Book.where(title: word)
    elsif method == 'forward_match'
      Book.where('title LIKE?', word + '%')
    elsif method == 'backward_match'
      Book.where('title LIKE?', '%' + word)
    else
      Book.where('title LIKE?', '%' + word + '%')
    end
  end

  # 今日
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  # 昨日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  # 2~6日前
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) }
  # 今週
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  # 先週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
end
