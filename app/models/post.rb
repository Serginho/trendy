# -*- encoding : utf-8 -*-
class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :source
  has_many :shares
  has_many :rates

  validates_presence_of :title, :content, :url, :category_id, :source_id , message: 'Este campo es requerido.'
  validates :category_id, numericality: true, allow_nil: false
  validates :source_id, numericality:true,  allow_nil: false
  validates_length_of :content, minimum: 20, message: 'Debe ser mayor de 20 caracteres'
  validates_uniqueness_of :title, message: 'Este post ya existe.'
  validates_format_of :url, :with => URI.regexp(['http']), message: 'Url inválida'
  validates_format_of :image, :with => URI.regexp(['http']), allow_blank: true

  def self.posts_for_index(user_id = nil)
    c = Customize.where(user_id: user_id).all
    total = 0
    c.each do |customize|
      total += customize.rank
    end
    if user_id && total != 0 then
      result = []
      c.each do |customize|
        limit = (customize.rank.to_f/total.to_f)*15
        result += self.find_by_sql("select p.id, p.title, posts.content, posts.url, posts.image, p.category_id, p.category_name, posts.created_at, p.avg_score, p.num_shares
                      from (select posts.id,title, categories.id as category_id, categories.name as category_name, avg(score) as avg_score, count(shares.id) as num_shares
	                    from ((posts inner join categories on posts.category_id = categories.id)
	                    left join rates on posts.id = rates.post_id)
	                    left join shares on posts.id = shares.post_id
                      group by posts.id, posts.title, categories.id, categories.name) as p inner join posts on posts.id = p.id
                      where p.category_id = #{customize.category_id}
                      order by p.avg_score + p.num_shares").take(limit.to_i)
      end
      return result
    else
      self.find_by_sql('select p.id, p.title, posts.content, posts.url, posts.image, p.category_id, p.category_name, posts.created_at, p.avg_score, p.num_shares
                      from (select posts.id,title, categories.id as category_id, categories.name as category_name, avg(score) as avg_score, count(shares.id) as num_shares
	                    from ((posts inner join categories on posts.category_id = categories.id)
	                    left join rates on posts.id = rates.post_id)
	                    left join shares on posts.id = shares.post_id
                      group by posts.id, posts.title, categories.id, categories.name) as p inner join posts on posts.id = p.id
                      order by p.avg_score + p.num_shares')
    end
  end

end
