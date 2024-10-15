#all u need to know is how to write ur tests is it for ur model or for ur controlle ror service 
# dirst thing alwys we want that string be immutable 

#freeze_literal_string: true 

Rspec.describe Business::Invoice do
    context "when a client pass a payment"
    it "start a transaction" do 
        # Arrange 
        membership = create(:membership, has_paid_subscription: true)
        tier = build(:tier)
        allow(SubscriptionNotifier).to receive(:notify_trial_started)

        # Act
        TrieWithTrialUpgrade.new(membership:, tier:).upgrade 

        # Assert 
        expect(SubscriptionNotifier).to have_received(:notify_trial_started).with(subscription, trial)
    end 
end
