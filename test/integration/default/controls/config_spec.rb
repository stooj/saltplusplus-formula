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

control 'saltplusplus ssf file root directory' do
  title 'should exist'

  describe directory('/srv/salt/ssf/files/fishers/git') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0700' }
  end
end

control 'saltplusplus ssf key' do
  title 'should match desired lines'

  describe file('/srv/salt/ssf/files/fishers/git/git_30_create_PR.sh') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0600' }
    its('content') { should include 'Only use this for debugging!' }
    its('content') { should include 'GH_TOKEN=ABC123' }
  end
end

