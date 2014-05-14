module TwentyfourSevenOffice
  module DataTypes
    # http://help.24sevenoffice.com/index.php?title=API:Authenticate_Datatyper#Credential
    class Credential
      include Virtus.model

      attribute :username, String
      attribute :password, String
      attribute :application_id, String
      attribute :identity_id, String

      def to_message_hash
        h = {
          credential: {
            ApplicationId: application_id,
            Password: password,
            Username: username
          }
        }

        identity_id.nil? ? h : h.merge({credential: {IdentityId: identity_id}})
      end
    end
  end
end
