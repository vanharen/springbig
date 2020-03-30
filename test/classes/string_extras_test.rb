require 'test_helper'

class StringExtrasTest < ActiveSupport::TestCase
  test "valid_phone" do
    assert_not("999".valid_phone?, "must be 10 digits")
    assert_not("999a999a9999".valid_phone?, "must not include alpha")
    assert_not("9999-9999-9999".valid_phone?, "must be 10 digits")
    assert_not("1-800-MATTRESS".valid_phone?, "must not include alpha")
    assert_not("phone number".valid_phone?, "must not include alpha")
    assert_not("099-999-9999".valid_phone?, "must not have '0' in position 0 or 3")
    assert_not("900-012-4455".valid_phone?, "must not have '0' in position 0 or 3")
    assert_not("123.456-7890".valid_phone?, "must not have '1' in position 0 or 3")
    assert_not("999.156-7890".valid_phone?, "must not have '1' in position 0 or 3")

    assert("999-999-9999".valid_phone?)
    assert("321.456-7890".valid_phone?)
    assert("(321) 456-7890".valid_phone?)
  end

  test "valid_email" do
    assert_not("999".valid_email?, "must have a domain")
    assert_not("foo@bar@quux.com".valid_email?, "shouldn't have two '@' signs")
    assert_not("#{'a'*70}@example.com".valid_email?, "address must be <= 64 chars")
    assert_not("abcdef@#{'a'*255}.example.com".valid_email?, "domain must be <= 255 chars")

    assert("joe.schmo@example.com".valid_email?)
    assert("joe.schmo@more.example.com".valid_email?)
  end

  test "valid_name" do
  end
end
