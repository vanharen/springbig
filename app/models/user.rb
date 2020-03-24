# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  email        :string
#  error_string :string
#  first        :string
#  last         :string
#  phone        :string
#  row_number   :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_file_id :bigint
#
class User < ApplicationRecord
  belongs_to :user_file

  scope :with_error,    -> { where("error_string is not null") }
  scope :without_error, -> { where("error_string is null") }
end
