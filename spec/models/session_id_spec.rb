require "spec_helper"

describe TwentyfourSevenOffice::Models::SessionId do
  describe "#to_cookie" do
    it "returns the session id as an instance of HTTPI::Cookie" do
      sid = TwentyfourSevenOffice::Models::SessionId.new(session_id: "abcd")
      cookie = sid.to_cookie
      expect(cookie.class).to be(HTTPI::Cookie)
      expect(cookie.name_and_value).to eq("ASP.NET_SessionId=abcd")
    end
  end
end
