require 'test_helper'
require 'pry'

class UserTest < ActiveSupport::TestCase

def setup 
  @subject = User.new
end

test 'this string' do 
  assert true
end

test "email should be required" do
  assert_includes(@subject.errors[:email], "can't be blank")
end

end