require 'yaml'

describe 'should fail without a path or host defined' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).not_to be_truthy
    end
  end
  
end