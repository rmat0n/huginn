require 'spec_helper'

describe UserCredential do
  describe "validation" do
    it { is_expected.to validate_uniqueness_of(:credential_name).scoped_to(:user_id) }
    it { is_expected.to validate_presence_of(:credential_name) }
    it { is_expected.to validate_presence_of(:credential_value) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe "mass assignment" do
    it { is_expected.to allow_mass_assignment_of :credential_name }

    it { is_expected.to allow_mass_assignment_of :credential_value }

    it { is_expected.not_to allow_mass_assignment_of :user_id }
  end

  describe "cleaning fields" do
    it "should trim whitespace" do
      user_credential = user_credentials(:bob_aws_key)
      user_credential.credential_name = " new name "
      user_credential.credential_value = " new value "
      user_credential.save!
      expect(user_credential.credential_name).to eq("new name")
      expect(user_credential.credential_value).to eq("new value")
    end
  end
end
