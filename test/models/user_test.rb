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
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
