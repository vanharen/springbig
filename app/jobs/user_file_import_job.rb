# coding: utf-8
require 'smarter_csv'

class UserFileImportJob < ApplicationJob
  queue_as :default

  def perform(user_file)
    # Grab the data from the blob
    csv_file = user_file.csv_file.download
    # SmarterCSV will return an array of hashes for each line
    csv_data = SmarterCSV.process(StringIO.new(csv_file))

    # Iterate over the lines, validating the data and creating User
    # records, adding row_number and user_file_id to the hash
    csv_data.each_with_index { |user_hash, idx|

      # Make sure everything is strings, because SmarterCSV will
      # return ints for things that look like ints
      user_hash.each { |k,v| user_hash[k] = v.to_s }

      # Add row_number to hash
      user_hash[:row_number] = idx

      errors = []

      first, last = user_hash[:first], user_hash[:last]
      errors << "Invalid first name"    if !name_valid?(first)
      errors << "Invalid last name"     if !name_valid?(last)
      
      # - Neither first name or last name are required, however, the
      #   last name cannot be specified if first name is not present.
      errors << "Last name may not be present without first name" if (first.nil? && !last.nil?)
        
      phone = user_hash[:phone]
      phone.gsub!(/[-\.\(\)]/, '')            # Strip dash, dot, parens
      errors << "Invalid phone number"  if !phone_valid?(phone)

      errors << "Invalid email address" if !email_valid?(user_hash[:email])

      # Any errors to report?
      user_hash[:error_string] = errors.join(", ") if !errors.empty?

      user_file.users.create(user_hash)
    }
  end

  private

  # - Phone numbers may contain characters 0-9,-,.(,). Punctuation
  #   need not adhere to a particular format or match,
  #   e.g. “123.456-8888” and “87644.45523” are both legal.
  # - Phone numbers must contain exactly 10 digits. Assuming
  #   0-origin indexing, positions 0 and 3 may not contain
  #   characters ‘0’ or ‘1’.
  def phone_valid?(phone)
    /[0-9]{10}/.match?(phone) &&
      ([phone[0],phone[3]] & ["0","1"]).empty?  # Union empty?
  end
      
  # - Email addresses must be standard and valid.
  #   For this we will *mostly* follow RFC 3696 rules
  #     (see: https://en.wikipedia.org/wiki/Email_address,
  #           https://tools.ietf.org/html/rfc3696)
  #   - Must match "local_part"@"domain"
  #   - We will ignore quoted addresses, which have extended rules
  #   - "local_part" may consist of alphanumerics plus "!#$%&'*+-/=?^_`.{|}~"
  #   - for simplicity we will ignore the requirement that period
  #     not be first or last, nor two periods in a row
  #   - "local_part" must be <= 64 chars
  #   - "domain" must be <= 255 chars and consist of alphanumerics plus "-"
  #   - "domain" must contain at least one period in the middle of the string
  #   - for simplicity we will ignore the requirement that hyphen
  #     not be first or last, nor that the TLD be not all-numeric
  def email_valid?(email)
    parts = email.split("@")
    return false if parts.size != 2

    local_part, domain = parts

    return false if domain.split(".").size < 2 # must have one period

    /^[\w!\#$%&'*+-\/=?^_`.{\|}~]{1,64}$/.match?(local_part) &&
      /^[A-Za-z0-9\-\.]{1,255}$/.match?(domain)
  end

  # - Names must either be nil, or if non-nil must be alpha only and
  #   at least 2 characters long
  def name_valid?(name)
    name.nil? || /^[A-Za-z]{2,}$/.match?(name)
  end

end
