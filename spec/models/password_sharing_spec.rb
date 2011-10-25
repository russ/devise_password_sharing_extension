require 'spec_helper'

describe Devise::Models::PasswordSharing do
  subject { user_fixture }

  it { should have_many(:login_events) }

  describe "#create_login_event!" do
    it "creates login event with ip information" do
      lambda {
        mock_geo_database
        subject.create_login_event!(request_fixture)
      }.should change(LoginEvent, :count).by(1)
    end
  end

  describe "#ban_for_password_sharing!" do
    context "when banning is enabled" do
      it "sets :banned_for_password_sharing_at to the current time" do
        subject.ban_for_password_sharing!
        subject.banned_for_password_sharing_at.should_not be_nil
      end
    end

    context "when banning is not enabled" do
      it "does not ban user" do
        User.enable_banning = false
        subject.ban_for_password_sharing!
        subject.banned_for_password_sharing_at.should be_nil
      end
    end
  end

  describe "#password_sharing?" do
    context "when there is password sharing" do
      before do
        10.times do
          mock_geo_database(:city => 'Las Vegas')
          subject.create_login_event!(request_fixture)
        end
      end

      it "returns true" do
        subject.password_sharing?.should be_true
      end
    end

    context "when there is no password sharing" do
      it "returns false" do
        subject.password_sharing?.should be_false
      end
    end
  end
end
