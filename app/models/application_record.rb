class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Nifty hack that lets us refer to ActiveRecord objects as if they
  # were an array
  def self.[](id)
    find_by_id(id)
  end

end
