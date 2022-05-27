require 'rails_helper'

describe User do
  describe '.create_transaction' do
    it 'create a new transaction' do
      user = create :user, spend_money: 100

      expect(user.transactions.last.amount).to eq 100
    end
  end
end
