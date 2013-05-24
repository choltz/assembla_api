require "assembla_api/user"
require "typhoeus"

describe AssemblaApi::User do
  before do
  end

  it "should return an error if there's a problem with the api call" do
  end

  it "returns a user based on the username provided" do
    user = AssemblaApi::User.find("Zepalesque")
    user.class.name.should eq "AssemblaApi::User"
  end

end
