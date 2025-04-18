require 'rails_helper'

RSpec.describe Member do
  it 'has a valid factory' do
    expect(create(:member)).to be_valid
  end
end
