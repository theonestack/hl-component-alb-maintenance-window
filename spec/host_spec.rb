require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/host.test.yaml")).to be_truthy
    end
  end

  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/host/alb-maintenance-window.compiled.yaml") }

  context 'Resource MaintenanceWindowRule1' do

    let(:properties) { template["Resources"]["MaintenanceWindowRule1"]["Properties"] }

    it 'has property Conditions' do
      expect(properties["Conditions"][0]["Field"]).to eq('host-header')
      expect(properties["Conditions"][0]["Values"][0]).to eq('test.*')
    end

  end

end