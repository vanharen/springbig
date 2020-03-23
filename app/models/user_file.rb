# == Schema Information
#
# Table name: user_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserFile < ApplicationRecord
  has_one_attached :csv_file
end
