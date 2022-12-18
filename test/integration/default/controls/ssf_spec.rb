# frozen_string_literal: true

control 'saltplusplus ssf file root directory' do
  title 'should exist'

  describe directory('/srv/salt/ssf/files/fishers/git') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0700' }
  end
end

control 'saltplusplus ssf script' do
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

control 'saltplusplus ssf repo directory' do
  title 'should exist'

  describe directory('/srv/repos') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0700' }
  end
end

control 'saltplusplus ssf repo' do
  title 'should be cloned'

  describe directory('/srv/repos/template-formula') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end

control 'saltplusplus ssf repo pillar example file' do
  title 'should match desired lines'

  describe file('/srv/repos/template-formula/pillar.example') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('content') { should include('TEMPLATE:') }
    its('content') { should include('TEMPLATE-config-file-file-managed:') }
  end
end
