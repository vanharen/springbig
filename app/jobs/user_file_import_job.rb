# coding: utf-8
require 'smarter_csv'

class UserFileImportJob < ApplicationJob
  queue_as :default

  def perform(user_file)
    # Grab the data from the blob
    csv_file = user_file.csv_file.download
    # SmarterCSV will return an array of hashes for each line
    io = StringIO.new(csv_file)
    io.set_encoding "utf-8"
    csv_data = SmarterCSV.process(io,
                                  { convert_values_to_numeric: false })

    # Iterate over the lines, validating the data and creating User
    # records, adding row_number and user_file_id to the hash
    csv_data.each_with_index { |user_hash, idx|

      # Add row_number to hash
      user_hash[:row_number] = idx

      errors = []

      first, last = user_hash[:first] || "", user_hash[:last] || ""
      errors << "Invalid first name"    if !first.valid_name?
      errors << "Invalid last name"     if !last.valid_name?

      # - Neither first name or last name are required, however, the
      #   last name cannot be specified if first name is not present.
      errors << "Last name may not be present without first name" if (first.nil? && !last.nil?)

      phone = user_hash[:phone]
      errors << "Invalid phone number"  if !phone&.valid_phone?

      email = user_hash[:email]
      errors << "Invalid email address" if !email&.valid_email?

      # Any errors to report?
      user_hash[:error_string] = errors.join(", ") if !errors.empty?

      user_file.users.create(user_hash)
    }
  end

end
