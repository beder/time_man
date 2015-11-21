require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with no role specified' do
    let!(:user) { User.new }

    describe 'role' do
      subject { user.role.to_sym }

      it { is_expected.to eq(:user) }
    end
  end

  context 'with manager role' do
    let!(:user) { User.new(role: :manager) }

    describe 'role' do
      subject { user.role.to_sym }

      it { is_expected.to eq(:manager) }
    end
  end

  context 'with admin role' do
    let!(:user) { User.new(role: :admin) }

    describe 'role' do
      subject { user.role.to_sym }

      it { is_expected.to eq(:admin) }
    end
  end
end
