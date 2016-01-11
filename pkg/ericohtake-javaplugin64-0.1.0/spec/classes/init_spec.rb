require 'spec_helper'
describe 'javaplugin64' do

  context 'with defaults for all parameters' do
    it { should contain_class('javaplugin64') }
  end
end
