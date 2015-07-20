# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs
  belongs_to :author, class_name: :User, foreign_key: :author_id
  has_many :comments
  has_many :votes, as: :votable

  def comments_by_parent_id
    comment_hash = Hash.new { |h, v| h[v] = [] }
    # comments = Post.find_by_sql(<<-SQL)
    #   SELECT
    #     comments.*
    #   FROM
    #     comments
    #   LEFT JOIN
    #     votes
    #   ON
    #     comments.id = votes.votable_id
    #   WHERE
    #     comments.post_id = #{id} AND (votes.votable_type = 'Comment' OR votes.votable_type IS NULL)
    #   GROUP BY
    #     comments.id
    #   ORDER BY
    #     SUM(votes.value) DESC
    # SQL
    comments.includes(:votes)
    comments.sort_by { |comment| -1 * comment.score }
    comments.each do |comment|
      comment_hash[comment.parent_comment_id] << comment
    end
    comment_hash
  end
end
