require "spec_helper"

describe TwentyfourSevenOffice::Services::Authentication do
  include Savon::SpecHelper

  before(:all) { savon.mock! }
  after(:all) { savon.unmock! }

  let(:login_response) { xml_fixture :login_response }

  subject { described_class }
 
  it "should login using a Community credential" do
    savon.expects(:login).with(message: {
      credential: {
        ApplicationId: "abcd1234",
        Password: "secret",
        Username: "test@example.com"
      }
    }).returns(login_response)

    credential = TwentyfourSevenOffice::DataTypes::Credential.new({
      username: "test@example.com",
      password: "secret",
      application_id: "abcd1234"
    })

    session_id = subject.login(credential: credential)

    expect(session_id.session_id).to eq("csjilsasysb1h245qmwvsumx")
  end
end
