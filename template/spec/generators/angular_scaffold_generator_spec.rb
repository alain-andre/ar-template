require 'rake'
require 'rails_helper'
require 'ammeter/init'
require 'rails/all'

# Generators are not automatically loaded by Rails
require 'generators/angular_scaffold/angular_scaffold_generator'

describe AngularScaffoldGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  dir = File.expand_path('../../../../../tmp', __FILE__)
  destination dir
  before do
    prepare_destination
  end

  # Verifies the file's contents the given structure in HTML files
  let (:test_html_structure){ %w(compte.nom, compte.description, compte.prix, compte.rdv, compte.validation, compte.heure, compte.creation) }

  # Verifies the file's contents the given structure in ruby files
  let (:test_rb_structure) { %w(nom, description, prix, rdv, validation, heure, creation) }

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

    describe 'in app/assets/javascripts/services/comptes_srv.js.coffee' do
      subject { file('app/assets/javascripts/services/comptes_srv.js.coffee') }
      it { is_expected.to exist }
    end

    describe 'in app/assets/templates/comptes/index.html.haml' do
      subject { file('app/assets/templates/comptes/index.html.haml') }
      it { is_expected.to exist }
      
      it 'respects the objects structure' do
        test_html_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

    describe 'in app/assets/templates/comptes/_filter.html.haml' do
      subject { file('app/assets/templates/comptes/_filter.html.haml') }
      it { is_expected.to exist }
    end

    describe 'in app/assets/templates/comptes/admin.html.haml' do
      subject { file('app/assets/templates/comptes/admin.html.haml') }
      it { is_expected.to exist }
      
      it 'respects the objects structure' do
        test_html_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

    describe 'in app/assets/templates/comptes/edit.html.haml' do
      subject { file('app/assets/templates/comptes/edit.html.haml') }
      it { is_expected.to exist }
    end

    describe 'in app/assets/templates/comptes/show.html.haml' do
      subject { file('app/assets/templates/comptes/show.html.haml') }
      it { is_expected.to exist }
      
      it 'respects the objects structure' do
        test_html_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

    describe 'in app/assets/templates/comptes/new.html.haml' do
      subject { file('app/assets/templates/comptes/new.html.haml') }
      it { is_expected.to exist }
    end

    describe 'in app/assets/templates/comptes/_form.html.haml' do
      subject { file('app/assets/templates/comptes/_form.html.haml') }
      it { is_expected.to exist }
      
      it 'respects the objects structure' do
        test_html_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
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

    describe 'in app/models/compte.rb' do 
      subject { file('app/models/compte.rb') }
      it { is_expected.to exist }
    end

    describe 'in config/locales/compte.en.yml' do 
      subject { file('config/locales/compte.en.yml') }
      it { is_expected.to exist }
    end

    describe 'the migration' do
      subject { migration_file('db/migrate/create_comptes.rb') }
      it { is_expected.to exist }
      it { is_expected.to be_a_migration } # verifies the file exists with a migration timestamp as part of the filename
      it { is_expected.to contain /create_table/ }

      it 'respects the objects structure' do
        test_rb_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

  end

end
