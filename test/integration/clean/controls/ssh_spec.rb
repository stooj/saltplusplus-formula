# # frozen_string_literal: true

control 'saltplusplus ssh key symlink' do
  title 'should not exist'

  describe file('/srv/salt/ssh/files/deploy_key') do
    it { should_not exist }
  end
end

control 'saltplusplus ssh file root directory' do
  title 'should not exist'

  describe directory('/srv/salt/ssh/files') do
    it { should_not exist }
  end
end

control 'saltplusplus ssh key' do
  title 'should not exist'

  describe file('/root/.ssh/id_ed25519') do
    it { should_not exist }
  end
end

control 'saltplusplus ssh public key' do
  title 'should not exist'

  describe file('/root/.ssh/id_ed25519.pub') do
    it { should_not exist }
  end
end
