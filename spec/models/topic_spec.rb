require 'rails_helper'
include RandomData

RSpec.describe Topic, type: :model do

  let(:topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

  it {should have_many(:posts)}

  it { should validate_length_of(:name).is_at_least(5)}
  it { should validate_length_of(:description).is_at_least(15)}
end
