class User < ActiveRecord::Base
  validates :name, :rut, :template, presence: true
  validates :rut, rut: true
  validates_uniqueness_of :rut

  has_many :user_courses, :dependent => :delete_all
end

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  template   :string(255)
#  rut        :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
