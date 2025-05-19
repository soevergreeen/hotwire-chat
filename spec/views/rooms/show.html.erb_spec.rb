require "rails_helper"

RSpec.describe "rooms/show.html.erb", type: :view do
  let(:room) { assign(:room, Room.create!(name: "Test Room")) }
  let!(:messages) do
    assign(:messages, [
      room.messages.create!(content: "Hello!"),
      room.messages.create!(content: "Welcome!")
    ])
  end

  before do
    # allow flash notice
    allow(view).to receive(:notice).and_return("Room was successfully updated.")
    # render turbo streams and frames
    render
  end

  it "displays the notice message" do
    expect(rendered).to have_css("p[style='color: green']", text: "Room was successfully updated.")
  end

  it "renders the room partial inside the turbo frame" do
    expect(rendered).to have_css("turbo-frame#room") do |frame|
      expect(frame.text).to include("Test Room")
    end
  end

  it "has links to edit and back" do
    expect(rendered).to have_link("Edit this room", href: edit_room_path(room))
    expect(rendered).to have_link("Back to rooms", href: rooms_path, visible: true)
  end

  it "has a destroy button" do
    expect(rendered).to have_selector("form button", text: "Destroy this room")
  end

  it "renders all messages" do
    messages.each do |msg|
      expect(rendered).to match(msg.content)
    end
  end

  it "includes the new_message turbo frame with correct src" do
    expect(rendered).to have_css("turbo-frame#new_message[src='#{new_room_message_path(room)}']")
  end
end
