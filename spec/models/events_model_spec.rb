require 'rails_helper'

RSpec.describe Event do
    describe 'event does not exist' do
        it 'should not be present' do
            event = Event.new
            expect(event.valid?).to eq(false)
        end
    end
end