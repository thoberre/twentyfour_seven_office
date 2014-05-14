require "spec_helper"

describe TwentyfourSevenOffice::DataTypes::SessionId do
  subject { described_class.new(session_id: "abcd") }

  describe "#to_cookie" do
    it "returns the session id as an instance of HTTPI::Cookie" do
      cookie = subject.to_cookie
      expect(cookie.class).to be(HTTPI::Cookie)
      expect(cookie.name_and_value).to eq("ASP.NET_SessionId=abcd")
    end
  end

  describe "#to_s" do
    it "returns the session id" do
      expect(subject.to_s).to eq("abcd")
    end
  end
end
