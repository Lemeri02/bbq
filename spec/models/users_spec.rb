require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_for_facebook_oauth' do
    # Создаём объект :access_token
    # В него записываем те данные, которые мы доставали их хеша
    let(:access_token) do
      double(
        :access_token,
        provider: 'facebook',
        info: double(email: 'ivan@example.com', name: 'Ivan Vovkin'),
        extra: double(raw_info: double(id: '2865974682365812'))
      )
    end

    # Ситуация: пользователь не найден
    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_facebook_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'ivan@example.com'
      end
    end

    # Ситуация: юзер найден по почте
    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'ivan@example.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end

    # Ситуация: юзер найден по провайдеру и урлу
    context 'when user is found by provider + url' do
      let!(:existing_user) do
        create(:user, provider: 'facebook',
               url: 'https://facebook.com/2865974682365812')
      end
      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_facebook_oauth(access_token)).to eq existing_user
      end
    end
  end

  describe '.find_for_vkontakte_oauth' do
    let(:access_token) do
      double(
        :access_token,
        provider: 'vkontakte',
        info: double(email: 'vasya@mail.com', name: 'Vasya Vkontaktin'),
        extra: double(raw_info: double(id: '333666888'))
      )
    end

    context 'when user is not found' do
      it 'returns newly created user' do
        user = User.find_for_vkontakte_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'vasya@mail.com'
      end
    end

    context 'when users profile on social network dont have email' do
      let!(:existing_user) { create(:user, email: '') }
      it 'returns newly created user' do
        user = User.find_for_vkontakte_oauth(access_token)

        expect(user).to be_persisted
        expect(user.email).to eq 'vasya@mail.com'
        byebug
      end
    end

    context 'when user is found by email' do
      let!(:existing_user) { create(:user, email: 'vasya@mail.com') }
      let!(:some_other_user) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_vkontakte_oauth(access_token)).to eq existing_user
      end
    end

    context 'when user is found by provider + url' do
      let!(:existing_user) do
        create(:user, provider: 'vkontakte',
               url: 'https://vk.com/333666888')
      end
      let!(:some_other_uer) { create(:user) }

      it 'returns this user' do
        expect(User.find_for_vkontakte_oauth(access_token)).to eq existing_user
      end
    end
  end
end
