require 'rails_helper'
include RandomData

RSpec.describe Post, type: :model do

  let(:topic) { create :topic }
  let(:user)  { create :user }
  let(:post)  { create :post }

  it { should have_many(:labelings)}
  it { should have_many(:labels).through(:labelings)}
  it { should have_many (:votes)}
  it { should have_many (:favorites) }
  it { should have_many (:comments)}
  it {should belong_to(:topic)}
  it {should belong_to(:user)}

  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:body)}
  it { should validate_presence_of(:topic)}
  it { should validate_presence_of(:user)}
  it { should validate_length_of(:title).is_at_least(5)}
  it { should validate_length_of(:body).is_at_least(20)}


  describe "voting" do
    before do
      3.times { post.votes.create!(value: 1) }
      2.times { post.votes.create!(value: -1) }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    end

    describe "#up_votes" do
      it "counts the number of votes with value = 1" do
        expect( post.up_votes ).to eq(@up_votes)
      end
    end

    describe "#down_votes" do
      it "counts the number of votes with value = -1" do
        expect( post.down_votes ).to eq(@down_votes)
      end
    end

    describe "#points" do
      it "returns the sum of all down and up votes" do
        expect( post.points ).to eq(@up_votes - @down_votes)
      end
    end
  end
end
