require 'ammeter/init'
require 'rails/generators'

# Generators are not automatically loaded by Rails
require 'generators/angular_model/angular_model_generator'

describe AngularModelGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  dir = File.expand_path('../../../../../tmp', __FILE__)
  destination dir
  before do
    prepare_destination
  end

  # custom matchers make it easy to verify what the generator creates
  describe 'The generated files' do

    before do
      run_generator %w(compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime)
    end

    describe 'in app/models/compte.rb' do 
      subject { file('app/models/compte.rb') }
      it { is_expected.to exist }
    end

    describe 'the migration' do
      subject { migration_file('db/migrate/create_comptes.rb') }
      it { is_expected.to exist }
      # verifies the file exists with a migration timestamp as part of the filename
      it { is_expected.to be_a_migration } 
      it { is_expected.to contain /create_table/ }

      it 'respects the objects structure' do
        test_rb_structure.each do |structure|
          expect(subject).to contain(structure)
        end
      end
    end

  end

end