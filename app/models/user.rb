# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  first      :string
#  last       :string
#  phone      :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
end
