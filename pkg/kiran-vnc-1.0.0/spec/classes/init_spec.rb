require 'spec_helper'
describe 'vnc' do

  context 'with defaults for all parameters' do
    it { should contain_class('vnc') }
  end
end
