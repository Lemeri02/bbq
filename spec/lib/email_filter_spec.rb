require 'rails_helper'
require_relative '../../lib/email_filter'

RSpec.describe EmailFilter do
  let(:user) { create(:user) }
  let(:commentator) { create(:user) }
  let(:subscriptions) { create_list(:subscription, 8) }
  let(:event) { create(:event, user: user, subscriptions: subscriptions) }
  let(:comment) { create(:comment, event: event, user: commentator) }

  context '#email_filter' do
    it 'email_list is not to be nil for Comment' do
      email_list = EmailFilter.email_list(comment)

      expect(comment).to be_instance_of(Comment)
      expect(email_list).not_to be nil
      expect(email_list).to be_instance_of(Array)
    end

    it 'email_list doesnt contailn emails with domain vkontakte or facebook' do
      email_list = EmailFilter.email_list(comment)

      email_list.each do |email|
        expect(email).not_to include('vkontakte', 'facebook')
      end
    end
  end
end
