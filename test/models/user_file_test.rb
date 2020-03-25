# == Schema Information
#
# Table name: user_files
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserFileTest < ActiveSupport::TestCase
  test "should create a new user_file" do
    uf = UserFile.create
    assert_not_nil uf, "saved user_file object"
  end
end
