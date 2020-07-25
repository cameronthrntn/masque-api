require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:topics).dependent(:destroy) }
  it { should validate_presence_of(:access) }
end
