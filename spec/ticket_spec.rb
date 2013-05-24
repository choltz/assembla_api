require "assembla_api/ticket"
require "typhoeus"

describe AssemblaApi::Ticket do
  before do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    @space = AssemblaApi::Space.all.last
  end

  it "should return an error if there's a problem with the api call" do
  end

  it "returns the ticket based on the id provided" do
    stub_api_request_returns_ticket
    ticket = AssemblaApi::Ticket.find(@space.id, 55172833)
    ticket.class.name.should eq "AssemblaApi::Ticket"
  end

  it "returns the ticket based on the ticket number provided" do
    stub_api_request_returns_ticket
    ticket = AssemblaApi::Ticket.find_by_number(@space.id, 13)
    ticket.class.name.should eq "AssemblaApi::Ticket"
  end

  it "returns an error if creating a ticket without specifying the space" do
    expect {
      AssemblaApi::Ticket.create :summary => "this is a ticket", :description => "This is the ticket description"
    }.to raise_error("space_id is required when creating a ticket")
  end

  it "creates a ticket with the specified information" do
    stub_api_request_returns_ticket

    ticket = AssemblaApi::Ticket.create :space_id             => @space.id,
                                        :summary              => "new ticket",
                                        :description          => "this is the ticket description",
                                        :priority             => 5,
                                        :created_on           => Date.today - 5,
                                        :importance           => 5,
                                        :space_id             => "cIPad2W9mr4OkOacwqjQXA",
                                        :working_hours        => 4,
                                        :estimate             => 4

    ticket.class.name.should eq "AssemblaApi::Ticket"
    ticket.id.should eq            1000
    ticket.number.should eq        7
    ticket.summary.should eq       "new ticket"
    ticket.description.should eq   "this is the ticket description"
    ticket.priority.should eq      5
    ticket.created_on.should eq    "2013-05-18T00:00:00Z"
    ticket.importance.should eq    7
    ticket.space_id.should eq      "cIPad2W9mr4OkOacwqjQXA"
    ticket.working_hours.should eq 4
    ticket.estimate.should eq      4

  end

  it "should return an array of all tickets" do
    AssemblaApi::Ticket.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    tickets = AssemblaApi::Ticket.all(@space.id)
    tickets.is_a?(Array).should eq true
    tickets.first.class.name.should eq "AssemblaApi::Ticket"
  end

  it "should build an instance of the space object from a hash" do
    ticket_hash = {
      :assigned_to_id       => "dlkReOAYir4RxHacwqjQYw",
      :completed_date       => nil,
      :component_id         => nil,
      :created_on           => "2013-01-30T13:28:11-08:00",
      :custom_fields        => {},
      :description          => "build a system to\\n\\n1. build a report in the background\\n2. build a report a  :ing to a set of SQL / Mongo calls",
      :estimate             => 1.0,
      :id                   => 44785123,
      :importance           => 0.0,
      :is_story             => false,
      :milestone_id         => 2596703,
      :notification_list    => "dlkReOAYir4RxHacwqjQYw",
      :number               => 1,
      :permission_type      => 0,
      :priority             => 1,
      :reporter_id          => "dlkReOAYir4RxHacwqjQYw",
      :space_id             => "dGtbV6AYir4PwWacwqEsg8",
      :state                => 1,
      :status               => "New",
      :story_importance     => 0,
      :summary              => "build download report infrastructure",
      :total_estimate       => 1.0,
      :total_invested_hours => 0.0,
      :total_working_hours  => 0.0,
      :updated_at           => "2013-02-21T09:19:24-08:00",
      :working_hours        => 16.0
    }

    ticket = AssemblaApi::Ticket.send(:build_from_hash, ticket_hash)

    # enumerate through the hash keys and ensure that the space object
    # matches them all
    ticket_hash.each do |key, value|
      ticket.send(key).should eq ticket_hash[key]
    end
  end

  def stub_api_request_returns_ticket
    AssemblaApi::Ticket.stub(:api_request) {
      { :id            => 1000,
        :number        => 7,
        :summary       => "new ticket",
        :description   => "this is the ticket description",
        :priority      => 5,
        :created_on    => "2013-05-18T00:00:00Z",
        :importance    => 7,
        :space_id      => "cIPad2W9mr4OkOacwqjQXA",
        :working_hours => 4,
        :estimate      => 4 }
    }
  end

end
