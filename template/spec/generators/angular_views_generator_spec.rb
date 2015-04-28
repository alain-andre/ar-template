require 'ammeter/init'
require 'rails/generators'

# Generators are not automatically loaded by Rails
require 'generators/angular_views/angular_views_generator'

describe AngularViewsGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  dir = File.expand_path('../../../../../tmp', __FILE__)
  destination dir
  before do
    prepare_destination
  end

  # Verifies the file's contents the given structure in HTML files
  let (:test_html_structure){ %w(compte.nom compte.description compte.prix compte.rdv compte.validation compte.heure compte.creation) }

  # custom matchers make it easy to verify what the generator creates
  describe 'The generated files' do

    before do
      run_generator %w(compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime)
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

    describe 'in config/locales/compte.en.yml' do 
      subject { file('config/locales/compte.en.yml') }
      it { is_expected.to exist }
    end

  end

end