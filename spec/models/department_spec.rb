require 'rails_helper'

describe Department do
  it { should belong_to(:company) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:company) }
end
