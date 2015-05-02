require 'rails_helper'

describe Department do
  it { should belong_to(:company) }
  it { should have_many(:data_sheets) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:company) }
end
