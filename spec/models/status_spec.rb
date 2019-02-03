require 'rails_helper'

RSpec.describe Status, type: :model do

  context 'with a status' do
    it 'should be invalid if it doesn\'t have a description' do
      status = Status.new()
      expect(status.valid?).to eq(false)
    end
    it 'should be valid if it does have a description' do
      status = Status.new(description: 'Test description')
      expect(status.valid?).to eq(true)
    end
  end

end
