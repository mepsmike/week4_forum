class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :categories, :through => :topic_categoryships
	has_many :topic_categoryships

	has_many :comments,:dependent => :destroy
	
  has_many :favorites
  has_many :user_favorites, :through => :favorites, :source => :user
  #has_many :users, :through => :favorites

  has_many :likes
  has_many :user_likes, :through => :likes, :source => :user
	

	has_many :topic_tagship
	has_many :tags, :through => :topic_tagship


	has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def tag_list
    self.tags.map{ |x| x.name }.join(",")
  end

  def tag_list=(str)
    ids = str.split(",").map do |tag_name|
      tag_name.strip!
      tag = Tag.find_by_name( tag_name ) || Tag.create( :name => tag_name )
      tag.id
    end

    self.tag_ids = ids
  end
end
