# frozen_string_literal: true

require 'spec_helper'

describe Spree::Order do
  describe '#finalize!' do
    context 'the order contains gift cards and transitions to complete' do
      subject { order.finalize! }

      let(:gift_card) { create(:virtual_gift_card) }
      let(:order) { create(:order_with_line_items, state: 'complete', line_items: [gift_card.line_item]) }

      it 'makes the gift card redeemable' do
        subject
        expect(gift_card.reload.redeemable).to be true
        expect(gift_card.reload.redemption_code).to be_present
      end
    end
  end
end
