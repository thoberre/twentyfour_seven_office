require "spec_helper"

describe TwentyfourSevenOffice::Services::Authentication do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:login_response) do
    <<-XML
    <soap:Envelope
      xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xmlns:xsd="http://www.w3.org/2001/XMLSchema">
      <soap:Body>
        <LoginResponse xmlns="http://24sevenOffice.com/webservices">
          <LoginResult>csjilsasysb1h245qmwvsumx</LoginResult>
        </LoginResponse>
      </soap:Body>
    </soap:Envelope>
    XML
  end

  subject { described_class }
 
  it "should login using a Community credential" do
    savon.expects(:login).with(message: {
      credential: {
        ApplicationId: "abcd1234",
        Password: "secret",
        Username: "test@example.com"
      }
    }).returns(login_response)

    session_id = subject.login("test@example.com", "secret", "abcd1234")

    expect(session_id.session_id).to eq("csjilsasysb1h245qmwvsumx")
  end
end
