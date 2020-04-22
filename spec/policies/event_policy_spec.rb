require 'rails_helper'

RSpec.describe EventPolicy, type: :policy do
  let(:event_owner) { FactoryBot.create(:user) }
  let(:some_event) { FactoryBot.create(:event, user: event_owner) }
  let(:authenticated_user) { FactoryBot.create(:user) }

  subject { EventPolicy }

  context 'all users can show any events' do
    permissions :show? do
      it { is_expected.to permit(nil, Event) }
    end
  end

  context 'when anon user' do
    permissions :create? do
      it { is_expected.not_to permit(nil, Event) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(nil, some_event) }
    end
  end

  context 'when user is authenticated' do
    permissions :create? do
      it { is_expected.to permit(authenticated_user, Event) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(authenticated_user, some_event) }
    end
  end

  context 'when user is authorized' do
    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(event_owner, some_event) }
    end
  end
end
