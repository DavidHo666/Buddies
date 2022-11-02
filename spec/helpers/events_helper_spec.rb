require 'rails_helper'

RSpec.describe EventsHelper do
    describe 'is_hilite' do
        it 'should return hilite if the key is the same as the sort key' do
        @sort_key = "event_name"
        expect(is_hilite("event_name")).to eq("hilite")
        end
    
        it 'should return nil if the key is not the same as the sort key' do
        @sort_key = "event_name"
        expect(is_hilite("tag")).to eq(nil)
        end
    end
end