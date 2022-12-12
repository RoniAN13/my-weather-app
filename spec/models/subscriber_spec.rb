require 'rails_helper'

RSpec.describe Subscriber, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
   it { should allow_value("email@addresse.foo").for(:email) }
   it { should_not allow_value("email@addresse").for(:email) }
   it { should_not allow_value("email.foo").for(:email) }
   it { should_not allow_value("email").for(:email) }
   it { should validate_presence_of(:latitude) }
   it { should validate_presence_of(:longitude) }
  end
end
