require "assembla_api"

describe AssemblaApi::User do
  before do
  end

  it "returns a user based on the username provided" do
    stub_api_request_returns_user
    user = AssemblaApi::User.find("Zepalesque")
    user.class.name.should eq "AssemblaApi::User"
  end

  def stub_api_request_returns_user
    AssemblaApi::User.stub(:api_request) {
      { :email        => "choltz@gmail.com",
        :id           => "absNj6E-ur4OTHacwqjQYw",
        :im           => {"type"=>"", "id"=>""},
        :im2          => {"type"=>"", "id"=>""},
        :login        => "Zepalesque",
        :name         => "Chris Holtz",
        :organization => "",
        :phone        => "",
        :picture      => "http://www.assembla.com/v1/users/absNj6E-ur4OTHacwqjQYw/picture" }
      }
  end

  def stub_error_message
    AssemblaApi::User.stub(:api_request) {
      { :error        => "something went wrong" }
    }
  end



end
