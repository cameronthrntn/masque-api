require 'rails_helper'

RSpec.describe Mask, type: :model do
  it { should validate_presence_of(:mask) }
  it { should validate_presence_of(:colour) }
end
