# frozen_string_literal: true

control 'saltplusplus ssf git script' do
  title 'should not exist'

  describe file('/srv/salt/ssf/files/fishers/git/git_30_create_PR.sh') do
    it { should_not exist }
  end
end

control 'saltplusplus ssf file root directory' do
  title 'should not exist'

  describe directory('/srv/salt/ssf/files/fishers/git') do
    it { should_not exist }
  end
end

control 'saltplusplus ssf repo' do
  title 'should not exist'

  describe directory('/srv/repos/template-formula') do
    it { should_not exist }
  end
end

control 'saltplusplus ssf repo directory' do
  title 'should not exist'

  describe directory('/srv/repos') do
    it { should_not exist }
  end
end
