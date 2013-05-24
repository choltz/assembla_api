require "assembla_api/space"
require "typhoeus"

describe AssemblaApi::Space do

  before do
  end

  it "should return an error if there's a problem with the api call" do

  end

  it "has a list of associated tickets" do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    AssemblaApi::Ticket.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }

    spaces = AssemblaApi::Space.all
    spaces.first.tickets.first.is_a?(AssemblaApi::Ticket).should eq true
  end

  it "should return an array of all spaces" do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    spaces = AssemblaApi::Space.all
    spaces.is_a?(Array).should eq true
    spaces.first.is_a?(AssemblaApi::Space).should eq true
  end

  it "should build an instance of the space object from a hash" do
    space_hash = { "is_commercial"          => true,
                   "is_manager"            => true,
                   "status"                => 1,
                   "restricted"            => false,
                   "tabs_order"            =>  "--- \n- tickets\n- milestones\n- team\n- stream\n- admin\n- source_git\n- time\n",
                   "updated_at"            => "2013-01-30T21:26:52Z",
                   "team_tab_role"         => 0,
                   "wiki_name"             => "the_wiki_name",
                   "parent_id"             => nil,
                   "team_permissions"      => 2,
                   "is_volunteer"          => false,
                   "commercial_from"       => "2013-01-30T21:25:53Z",
                   "last_payer_changed_at" => nil,
                   "banner_text"           => "",
                   "created_at"            => "2013-01-30T21:20:31Z",
                   "share_permissions"     => true,
                   "public_permissions"    => 0,
                   "approved"              => false,
                   "restricted_date"       => nil,
                   "watcher_permissions"   => 1,
                   "can_apply"             => true,
                   "style"                 => "",
                   "banner_link"           => nil,
                   "description"           => nil,
                   "banner_height"         => nil,
                   "default_showpage"      => "Tickets",
                   "can_join"              => false,
                   "name"                  => "the_name",
                   "banner"                => nil,
                   "id"                    => "the_id" }

    space = AssemblaApi::Space.send(:build_from_hash, space_hash)

    # enumerate through the hash keys and ensure that the space object
    # matches them all
    space_hash.each do |key, value|
      space.send(key).should eq space_hash[key]
      space.is_commercial.should eq space_hash["is_commercial"]
    end
  end

end
