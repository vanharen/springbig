# coding: utf-8
module StringExtras

  # - Phone numbers may contain characters 0-9,-,.(,). Punctuation
  #   need not adhere to a particular format or match,
  #   e.g. “123.456-8888” and “87644.45523” are both legal.
  # - Phone numbers must contain exactly 10 digits. Assuming
  #   0-origin indexing, positions 0 and 3 may not contain
  #   characters ‘0’ or ‘1’.
  def valid_phone?
    /^[0-9]{10}$/.match?(self) &&
      ([self[0],self[3]] & ["0","1"]).empty?  # Union empty?
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
  def valid_email?
    parts = self.split("@")
    return false if parts.size != 2

    local_part, domain = parts

    return false if domain.split(".").size < 2 # must have one period

    /^[\w!\#$%&'*+-\/=?^_`.{\|}~]{1,64}$/.match?(local_part) &&
      /^[A-Za-z0-9\-\.]{1,255}$/.match?(domain)
  end

  # - Names must either be nil, or if non-nil must be alpha only and
  #   at least 2 characters long
  def valid_name?
    self.nil? || /^[A-Za-z]{2,}$/.match?(self)
  end

end
