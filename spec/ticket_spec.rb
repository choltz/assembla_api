require "assembla_api/ticket"
require "typhoeus"

describe AssemblaApi::Ticket do
  it "should return an array of all tickets" do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    space = AssemblaApi::Space.all.first

    tickets = space.tickets

    tickets.is_a?(Array).should eq true
    tickets.first.is_a?(AssemblaApi::Ticket).should eq true
  end

  it "should return an array of tickets based on the space id provided" do
    tickets = AssemblaApi::Ticket.find_by_space_id(1)

    tickets.is_a?(Array).should eq true
    tickets.first.is_a?(AssemblaApi::Ticket).should eq true
  end

end
