# frozen_string_literal: true

control 'saltplusplus ssh key' do
  title 'should match desired lines'

  describe file('/root/.ssh/id_ed25519') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0600' }
    its('content') { should include 'BEGIN OPENSSH PRIVATE KEY' }
  end
end

control 'saltplusplus ssh public key' do
  title 'should match desired lines'

  describe file('/root/.ssh/id_ed25519.pub') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0600' }
    its('content') { should include 'ssh-ed25519 abc' }
  end
end

control 'saltplusplus ssh file root directory' do
  title 'should exist'

  describe directory('/srv/salt/ssh/files') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0700' }
  end
end

control 'saltplusplus ssh key symlink' do
  title 'should exist'

  describe file('/srv/salt/ssh/files/deploy_key') do
    it { should be_symlink }
    it { should_not be_directory }
    its('link_path') { should eq '/root/.ssh/id_ed25519' }
  end
end
