require 'chefspec'

describe 'user::lock' do
  let(:chef_run) do
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
                          .converge(described_recipe)
  end

  it 'locks a user with an explicit action' do
    expect(chef_run).to lock_user('explicit_action')
    expect(chef_run).to_not lock_user('not_explicit_action')
  end

  it 'locks a user with attributes' do
    expect(chef_run).to lock_user('with_attributes').with(uid: '1234')
    expect(chef_run).to_not lock_user('with_attributes').with(uid: '5678')
  end

  it 'locks a user when specifying the identity attribute' do
    expect(chef_run).to lock_user('identity_attribute')
  end
end
