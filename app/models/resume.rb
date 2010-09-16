# == Schema Information
# Schema version: 20100916071749
#
# Table name: resumes
#
#  id                         :integer(4)      not null, primary key
#  user_id                    :integer(4)
#  name                       :string(255)
#  gender                     :integer(4)
#  working_years              :integer(4)
#  degree                     :string(255)
#  major                      :string(255)
#  birthday                   :date
#  hometown_province          :string(255)
#  hometown_city              :string(255)
#  current_residence_province :string(255)
#  current_residence_city     :string(255)
#  email                      :string(255)
#  phone_number               :string(255)
#  expected_salary            :string(255)
#  expected_positions         :string(255)
#  expected_job_location      :string(255)
#  current_working_state      :integer(4)
#  highlight_start_at         :date
#  highlight_end_at           :date
#  is_sending_sms             :boolean(1)
#  icon_type                  :integer(4)
#  created_at                 :datetime
#  updated_at                 :datetime
#  portrait_file_name         :string(255)
#  portrait_content_type      :string(255)
#  portrait_file_size         :integer(4)
#  portrait_updated_at        :datetime
#  self_intro                 :text
#  file_file_name             :string(255)
#  file_content_type          :string(255)
#  file_file_size             :integer(4)
#  file_updated_at            :datetime
#  partner_id                 :integer(4)
#

class Resume < ActiveRecord::Base
  attr_accessor :quick_resume

  has_enumeration_for :gender, :with => Gender
  has_enumeration_for :current_working_state, :with => WorkingState

  belongs_to :user
  belongs_to :partner
  ### been starred by company
  has_many :starred_resumes
  has_many :attentive_companies, :class_name => "Company", :through => :starred_resumes

  has_many :projects, :as => :parent, :dependent => :destroy
  has_many :skills, :dependent => :destroy
  has_many :schools, :dependent => :destroy
  has_many :previous_jobs, :dependent => :destroy
  has_many :languages, :dependent => :destroy
  has_many :cover_letters, :dependent => :destroy
  has_many :certifications, :dependent => :destroy
  has_many :job_applications
  has_many :starred_jobs
  has_many :jobs, :through => :starred_jobs

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :languages, :previous_jobs, :schools, :certifications, :cover_letters, :projects, :skills, :allow_destroy => true

  has_attached_file :portrait, :styles => { :thumb => "150x150>" }, :default_style => :thumb
  validates_attachment_content_type :portrait, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.portrait.size.present? }
  validates_attachment_size :portrait, :less_than => 1.megabytes, :message => "文件必需小于1M", :if => lambda {|obj| obj.portrait.size.present? }

  has_attached_file :file
  validates_attachment_size :file, :less_than => 10.megabytes, :message => "文件必需小于10M", :if => lambda {|obj| obj.file.size.present? }
  validates_attachment_presence :file, :if => lambda {|obj| obj.quick_resume == 'true' }

  validates_presence_of :name, :gender, :email, :working_years, :degree, :major, :birthday, :hometown_province, :hometown_city, :current_residence_province, :current_residence_city, :email, :phone_number, :expected_positions, :expected_job_location, :expected_salary, :current_working_state, :if => lambda {|obj| obj.quick_resume != 'true' and obj.file.size.nil? }
  validate :check_file_type_when_creating, :on => :create, :if => lambda {|obj| obj.quick_resume == 'true' }
  validate :check_file_type_when_updating, :on => :update, :if => lambda {|obj| obj.quick_resume == 'true' }


  def check_file_type_when_creating
    errors.add(:file, "文件格式错误，请上传 doc 或者 docx 格式的简历。") if !doc?
  end

  def check_file_type_when_updating
    errors.add(:file, "文件格式错误，请上传 doc 或者 docx 格式的简历。") if uploaded_an_illegal_file?
  end

  def uploaded_an_illegal_file?
    return false if self.file_file_name_changed?            ### not upload anything return legal uploading
    return true if !doc?(self.file_file_name_change.last)   ### if uploading something, it should be doc or pdf
    return false
  end

  def doc?(filename=self.file_file_name)
    filename and !!(File.extname(filename) =~ /docx?$/i)
  end

  def hometown
    "#{hometown_province} #{hometown_city}"
  end

  def current_residence
    "#{current_residence_province} #{current_residence_city}"
  end

  def portrait_path
    if portrait.size
      portrait.url
    elsif gender == Gender::MALE
      "/images/generic_male.gif"
    elsif gender == Gender::FEMALE
      "/images/generic_female.gif"
    end
  end

  def applied_to_job?(job)
    job_applications.where(:job_id => job).present?
  end

  def star_job(job, rating)
    starred_job = self.starred_jobs.where(:job_id => job.id).first

    if starred_job
      if rating > 0 and starred_job.update_attribute :rating, rating
        return "更新成功"
      elsif starred_job.destroy.present?
        return "取消成功"
      end
    else
      if self.starred_jobs.build(:job_id => job.id, :rating => rating).save
        return "收藏成功"
      else
        return "收藏失败"
      end
    end
  end

  [:name, :cover_letters, :certifications, :schools, :previous_jobs, :languages, :skills, :projects].each do |method_name|
    define_method("#{method_name}_present?") do |*args|
      self.send(method_name).present? ? "填写" : "未填写"
    end
  end

  [:name, :gender_humanize, :birthday, :degree, :working_years, :major, :hometown,
   :expected_salary, :current_residence, :expected_job_location, :expected_positions,
   :email, :phone_number, :current_working_state_humanize, :self_intro].each do |method_name|
    define_method("#{method_name}_if_present") do |*args|
      self.send(method_name).present? ? self.send(method_name) : "未填写"
    end
  end
end
