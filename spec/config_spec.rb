require "assembla_api/config"

describe AssemblaApi::Config do
  it "should let you set the api key" do
    AssemblaApi::Config.key    = "the_key"
    AssemblaApi::Config.key.should eq "the_key"

  end

  it "should let you set the api secret" do
    AssemblaApi::Config.secret = "the_secret"
    AssemblaApi::Config.secret.should eq "the_secret"
  end
end
