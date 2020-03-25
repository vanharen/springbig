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
  test "should not save without a user_file" do
    assert_not User.new.save, "saved without a user_file"
  end

  test "should save with a valid user_file id" do
    uf = UserFile.create
    assert_not_nil uf.users.create, "saved with a user_file object"
  end
end
