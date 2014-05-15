require "savon/mock/spec_helper"
require "twentyfour_seven_office"

def xml_fixture(name)
  File.read(File.join("spec", "fixtures", "#{name.to_s}.xml"))
end
