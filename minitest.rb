require 'minitest'

describe "Homepage Acceptance Test" do 
  it "must load successfully" do 
    get root_path
    assert_response :success
  end
end