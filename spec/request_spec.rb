require 'spec_helper'

describe 'Request Integration', :type => :request do
  include Rails.application.routes.url_helpers

  def create_user(attributes = {})
    User.create!(
      { :email => 'user@user.com',
        :password => 'password',
        :password_confirmation => 'password' }.merge(attributes))
  end

  def sign_in_as_user(user = nil)
    user ||= create_user
    visit(new_user_session_path)
    fill_in('user_email', :with => user.email)
    fill_in('user_password', :with => user.password)
    click_button('Sign in')
  end

  after do
    Capybara.reset_sessions!
  end

  describe 'requesting a non secure page' do
    it 'allows access' do
      visit(root_path)
      page.should have_content('HomeController')
    end
  end

  describe 'requesting a secure page' do
    describe 'when ban for password sharing is not on' do
      it 'allows access' do
        sign_in_as_user
        visit('/secure')
        page.should have_content('secure')
      end
    end

    describe 'when ban for password sharing is on' do
      it 'denies access' do
        sign_in_as_user(create_user(:banned_for_password_sharing_at => Time.now))
        visit('/secure')
        page.should have_content('secure')
      end
    end
  end
end
