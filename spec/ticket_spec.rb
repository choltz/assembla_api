require "assembla_api/ticket"
require "typhoeus"

describe AssemblaApi::Ticket do
  before do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    @space = AssemblaApi::Space.all.first
  end

  it "should return an error if there's a problem with the api call" do

  end

  it "should return an array of all tickets" do
    AssemblaApi::Ticket.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    tickets = AssemblaApi::Ticket.all(@space.id)
    tickets.is_a?(Array).should eq true
    tickets.first.is_a?(AssemblaApi::Ticket).should eq true
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

end
