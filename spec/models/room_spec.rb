require 'rails_helper'

RSpec.describe Room, type: :model do
  subject { Room.new(name: "Room321")}

it "is invalid without a name" do
  subject.name=nil
  expect(subject).not_to be_valid
  expect(subject.errors[:name]).to include("can't be blank")
end

it "is invalid if name shorter than 4 symbols" do
  subject.name = "dsd"
  expect(subject).not_to be_valid
  expect(subject.errors[:name]).to include("is too short (minimum is 4 characters)")
end

it "is invalid if name longer than 15 symbols" do
  subject.name = "h" * 16
  expect(subject).not_to be_valid
  expect(subject.errors[:name]).to include("is too long (maximum is 15 characters)")
end

it "is invalid when name consists only of digits" do
  subject.name = '2323432'
  expect(subject).not_to be_valid
  expect(subject.errors[:name]).to include("must contain non-digit characters")
end

it "is valid with a proper name" do
  subject.name = "Room#7"
  expect(subject).to be_valid
end

it "requires unique name" do
  Room.create!(name: "unique name")
  copy = Room.new(name: "unique name")
  expect(copy).not_to be_valid
  expect(copy.errors[:name]).to include("has already been taken")
end

end
