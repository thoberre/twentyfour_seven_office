module TwentyfourSevenOffice
  module DataTypes
    class Addresses
      include Virtus.model

      attribute :post, Address
      attribute :delivery, Address
      attribute :visit, Address
      attribute :invoice, Address
    end
  end
end
