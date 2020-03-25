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
  has_many :users, dependent: :destroy

  def num_rows
    users.count
  end

  def num_errors
    users.with_error.count
  end

end
