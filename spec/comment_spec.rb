require "assembla_api"

describe AssemblaApi::Comment do
  before do
    AssemblaApi::Space.stub(:api_request) { [{ :id => "the_id", :name => "the_name"}] }
    @space = AssemblaApi::Space.all.last
    AssemblaApi::Ticket.stub(:api_request) { [{ :id => "the_id", :name => "the_name", :number => 1 }] }
    @ticket = @space.tickets.first
  end

  it "returns a list of comments" do
    AssemblaApi::Comment.stub(:api_request) { [{ :id => "1", :comment => "this is a comment"}] }

    comments = AssemblaApi::Comment.all(@space.id, @ticket.number)
    comments.is_a?(Array).should eq true
    comments.first.class.name.should eq "AssemblaApi::Comment"
  end

  it "returns an error if creating a comment without specifying the space" do
    expect {
      AssemblaApi::Comment.create :comment => "this is a comment"
    }.to raise_error("space_id is required when creating a comment")
  end

  it "returns an error if creating a comment without specifying the ticket" do
    expect {
      AssemblaApi::Comment.create :comment => "this is a comment", :space_id => @space.id
    }.to raise_error("ticket_number is required when creating a comment")
  end

  it "creates a ticket with the specified information" do
    stub_api_request_returns_comment

    comment = AssemblaApi::Comment.create :space_id      => @space.id,
                                          :ticket_number => @ticket.number,
                                          :comment       => "This is the *other* comment"

    comment.class.name.should eq "AssemblaApi::Comment"
    comment.id.should eq         300552133
    comment.comment.should eq    "This is the *other* comment"
    comment.ticket_id.should eq  55172833
    comment.user_id.should eq    "absNj6E-ur4OTHacwqjQYw"
  end

  it "should build an instance of the comment object from a hash" do
    comment_hash = { :id             => 1000,
                     :comment        => "This is the *other* comment",
                     :id             => 300552133,
                     :ticket_id      => 55172833,
                     :user_id        => "absNj6E-ur4OTHacwqjQYw"
                   }

    comment = AssemblaApi::Comment.send(:build_from_hash, comment_hash)

    # enumerate through the hash keys and ensure that the space object
    # matches them all
    comment_hash.each do |key, value|
      comment.send(key).should eq comment_hash[key]
    end
  end

  def stub_api_request_returns_comment
    AssemblaApi::Comment.stub(:api_request) {
      { :id             => 1000,
        :comment        => "This is the *other* comment",
        :id             => 300552133,
        :ticket_id      => 55172833,
        :user_id        => "absNj6E-ur4OTHacwqjQYw" }
    }
  end

end
