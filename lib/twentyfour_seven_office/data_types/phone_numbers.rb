module TwentyfourSevenOffice
  module DataTypes
    class PhoneNumbers
      include Virtus.model

      attribute :home, PhoneNumber
      attribute :fax, PhoneNumber
      attribute :mobile, PhoneNumber
      attribute :primary, PhoneNumber
      attribute :work, PhoneNumber
    end
  end
end
