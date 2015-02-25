require 'rails_helper'
require 'ammeter/init'
require 'rails/all'

# Generators are not automatically loaded by Rails
require 'generators/angular_scaffold/angular_scaffold_generator'

describe AngularScaffoldGenerator, :type => :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  destination File.expand_path("../../../../../tmp", __FILE__)
  before do
    prepare_destination
  end

  # custom matchers make it easy to verify what the generator creates
  describe 'The generated files' do
    before do
      run_generator %w(compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime)
    end
    describe 'controllers javascripts' do
      # file - gives you the absolute path where the generator will create the file
      subject { file('app/assets/javascripts/controllers/comptes_ctrl.js') }
      # is_expected_to exist - verifies the file exists
      it { is_expected_to exist }
      # is_expected_to contain - verifies the file's contents
      it { is_expected_to contain(/CompteListCtrl/) }
      it { is_expected_to contain(/CompteViewCtrl/) }
    end

    # describe 'the migration' do
    #   subject { migration_file('db/migrate/create_posts.rb') }

    #   # is_expected_to be_a_migration - verifies the file exists with a migration timestamp as part of the filename
    #   it { is_expected_to exist }
    #   it { is_expected_to contain /create_table/ }
    # end
  end

end