require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a type super user"  do
    super_user = build(:user, role: 'SU')
    expect(super_user.is_super_user?).to be true
  end

  it "has a type super user"  do
    normal_user = build(:user, role: 'U')
    expect(normal_user.is_super_user?).to be false
  end


end
