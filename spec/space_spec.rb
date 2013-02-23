require "assembla_api/space"

describe AssemblaApi::Space do
  it "buh" do
    # Foodie::Food.portray("Broccoli").should eql("Gross!")
    AssemblaApi::Space.all().should eql([])
  end

#  it "anything else is delicious" do
#    Foodie::Food.portray("Not Broccoli").should eql("Delicious!")
#  end
end
