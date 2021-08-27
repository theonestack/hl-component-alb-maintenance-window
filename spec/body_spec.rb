require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/body.test.yaml")).to be_truthy
    end
  end

  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/body/alb-maintenance-window.compiled.yaml") }

  context 'Resource MaintenanceWindowRule1' do

    let(:properties) { template["Resources"]["MaintenanceWindowRule1"]["Properties"] }

    it 'has property Actions' do

      RSpec.describe properties["Actions"][0]["FixedResponseConfig"]["MessageBody"]["Fn::Sub"] do
        it { is_expected.to match(/StatusCode/) }
        it { is_expected.to match(/ExpireDate/) }
      end

      expect(properties["Actions"][0]["FixedResponseConfig"]["ContentType"]).to eq('application/json')
      
    end

  end

end