require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/priority.test.yaml")).to be_truthy
    end
  end

  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/priority/alb-maintenance-window.compiled.yaml") }

  context 'Resource MaintenanceWindowRule' do

    let(:properties) { template["Resources"].values[0]["Properties"] }
    let(:parameters) { template["Parameters"] }

    it 'Matching priorities' do
      expect(properties["Priority"]["Ref"]).to eq('Priority')
      expect(parameters["Priority"]["Default"]).to eq('1')
    end

  end

end