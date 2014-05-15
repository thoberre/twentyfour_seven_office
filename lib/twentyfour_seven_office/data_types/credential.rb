module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:Authenticate_Datatyper#Credential
    class Credential
      include Virtus.model
      include InputDataType

      attribute :username, String, required: true
      attribute :password, String, required: true
      attribute :application_id, String, required: true
      attribute :identity_id, String
    end
  end
end
