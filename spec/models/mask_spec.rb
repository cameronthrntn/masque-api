require 'rails_helper'

RSpec.describe Mask, type: :model do
  it { should validate_presence_of(:design) }
  it { should validate_presence_of(:colour) }
end
