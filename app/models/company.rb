# == Schema Information
# Schema version: 20100921080601
#
# Table name: companies
#
#  id                :integer(4)      not null, primary key
#  user_id           :integer(4)
#  name              :string(255)
#  company_type      :integer(4)
#  size              :integer(4)
#  province          :string(255)
#  city              :string(255)
#  address           :string(255)
#  homepage          :string(255)
#  contact_name      :string(255)
#  phone_number      :string(255)
#  desc              :text
#  created_at        :datetime
#  updated_at        :datetime
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#  views_count       :integer(4)      default(0)
#  partner_id        :integer(4)
#  permalink         :string(255)
#

class Company < ActiveRecord::Base
  # attr_accessor :accept_terms
  acts_as_views_count :delay => 30
  chinese_permalink :name
  acts_as_taggable

  has_enumeration_for :company_type, :with => CompanyType
  has_enumeration_for :size, :with => CompanySize

  belongs_to :partner
  # has_many :starred_resumes
  # has_many :candidates, :class_name => "Resume", :through => :starred_resumes
  has_many :jobs
  has_many :job_applications, :through => :jobs
  has_many :resumes, :through => :job_applications
  has_many :products, :as => :parent, :dependent => :destroy
  has_many :presentations, :as => :parent, :dependent => :destroy
  has_many :ads
  has_many :counters, :as => :parent, :dependent => :destroy, :order => "happened_at ASC"
  has_many :job_counters, :through => :jobs, :source => :counters
  belongs_to :user

  accepts_nested_attributes_for :user, :jobs, :products, :presentations, :allow_destroy => true

  validates_uniqueness_of :name
  validates_presence_of :name, :company_type, :size, :address, :contact_name, :province, :city, :desc  # phone_number
  # validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"
  validate :check_tag
  validate :check_logo

  ### to reprocess all image.
  # Company.all.each do |c|
  #   c.logo.reprocess!
  # end
  has_attached_file :logo, :styles => { :thumb => "200>x80", :fix_height => "283x50>", :title => "960>x100" }, :default_style => :thumb

  # validates_attachment_content_type :logo, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.logo.size.present? }
  # validates_attachment_size :logo, :less_than => 5.megabytes
  # validates_attachment_presence :logo
  def check_logo
    if self.logo.size.blank?
      errors.add :logo, "必须上传logo。"
    else
      errors.add :logo, "logo大小不能大于5M。" if self.logo.size > 5.megabytes
      errors.add :logo, "只允许上传 jpg, gif, png。" if File.extname(self.logo.original_filename) !~ /\.(jpe?g)|(gif)|(png)/i
    end
  end

  def check_tag
    errors.add :tag_list, '请不要超过5个关键字。' if self.tag_list.count > 5
    self.tag_list.each do |tag|
      errors.add :tag_list, '单个关键字太长。' if tag.size > 30
    end
  end

  def to_param
    "#{id}-#{permalink}"
  end

  def location
    self.province + self.city
  end

  def increased_views_count
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.increment!(:click)

    update_views_count
    views_count_s
  end

  def logo_width
    Paperclip::Geometry.from_file(logo.to_file(:original)).width
  end

  def logo_margin
    (960 - logo_width) / 2
  end

  def homepage_url
    homepage.sub(/^(http:\/\/)|(https:\/\/)?/,'http://')
  end
end
