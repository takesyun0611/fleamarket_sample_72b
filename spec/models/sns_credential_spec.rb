require 'rails_helper'

describe SnsCredential do
  describe '#create' do
    it "user_idが無くても認証できること" do
      sns_credential = build(:sns_credential, user_id: "")
      expect(sns_credential).to be_valid
    end
  end

end
