require 'ammeter/init'
require 'rails/generators'

# Generators are not automatically loaded by Rails
require 'generators/angular_controller/angular_controller_generator'

describe AngularControllerGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  dir = File.expand_path('../../../../../tmp', __FILE__)
  destination dir
  before do
    prepare_destination
  end

  # Verifies the file's contents the given structure in ruby files
  let (:test_rb_structure) { %w(nom description prix rdv validation heure creation) }
  
  # custom matchers make it easy to verify what the generator creates
  describe 'The generated files' do

    before do
      # Creates files modified in generator but created by template
      FileUtils.mkdir_p("#{dir}/app/controllers/api/v1/")
      File.open("#{dir}/app/controllers/api/v1/base.rb", 'w'){|file| file.write("Grape::API")}
      FileUtils.mkdir_p("#{dir}/app/assets/javascripts/")
      File.open("#{dir}/app/assets/javascripts/routes.js.coffee", 'w'){|file| file.write("stateProvider")}
      run_generator %w(compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime)
    end

    describe 'in app/assets/javascripts/services/comptes_srv.js.coffee' do
      subject { file('app/assets/javascripts/services/comptes_srv.js.coffee') }
      it { is_expected.to exist }
    end

    describe 'in app/controllers/api/v1/comptes.rb' do
      subject { file('app/controllers/api/v1/comptes.rb') }

      it { is_expected.to exist }
      # Test API functions exists
      it { is_expected.to contain(/Compte.all/) }
      it { is_expected.to contain(/Compte.find\(params\[:id\]\)/) }
      it { is_expected.to contain(/Compte.create!\(compte_params\)/) }
      it { is_expected.to contain(/Compte.find\(params\[:id\]\).update\(compte_params\)/) }
      it { is_expected.to contain(/Compte.find\(params\[:id\]\).destroy/) }

      it 'respects the objects structure' do
        test_rb_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

    describe 'in app/assets/javascripts/controllers/comptes_ctrl.js' do
      # file - gives you the absolute path where the generator will create the file
      subject { file('app/assets/javascripts/controllers/comptes_ctrl.js') }
      # is_expected_to exist - verifies the file exists
      it { is_expected.to exist }
      # is_expected_to contain - verifies the file's contents
      it { is_expected.to contain(/CompteListCtrl/) }
      it { is_expected.to contain(/CompteViewCtrl/) }
      it { is_expected.to contain(/CompteCreateCtrl/) }
      it { is_expected.to contain(/addCompte/) }
      it { is_expected.to contain(/updateCompte/) }
      it { is_expected.to contain(/deleteCompte/) }
    end

    # @todo https://github.com/alain-andre/ar-template/issues/15
    describe 'in app/assets/javascripts/routes.js.coffee' do
      subject { file('app/assets/javascripts/routes.js.coffee') }
      it { is_expected.to exist }
      it { is_expected.to contain(/stateProvider/) }

      pending "Test if routes.js.coffee contains the good routes"
      #it { is_expected.to contain(/\/comptes/) }
      #it { is_expected.to contain(/\/comptes\/:id\/view/) }
      #it { is_expected.to contain(/\/admin\/comptes/) }
      #it { is_expected.to contain(/\/admin\/comptes\/new/) }
      #it { is_expected.to contain(/\/admin\/comptes\/:id\/edit/) }
    end

    # @todo https://github.com/alain-andre/ar-template/issues/15
    describe 'in app/controllers/api/v1/base.rb' do
      subject { file('app/controllers/api/v1/base.rb') }
      it { is_expected.to exist }

      pending "Test if api/v1/base.rb contains 'mount API::V1::Comptes'"
      #it { is_expected.to contain(/mount API::V1::Comptes/) }
    end

  end

end