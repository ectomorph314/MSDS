require 'rails_helper'

describe CompanyUser do
  it { should belong_to(:user) }
  it { should belong_to(:company) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:company) }
end
