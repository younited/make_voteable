require 'spec_helper'
require 'action_controller'
require 'generator_spec/test_case'
require 'generators/make_voteable/make_voteable_generator'

describe MakeVoteableGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("/tmp", __FILE__)
  tests MakeVoteableGenerator

  before { prepare_destination }

  context "no options" do
    before do
      run_generator
    end

    specify do
      puts Dir.new(destination_root).entries
      destination_root.should have_structure {
        directory "db" do
          directory "migrate" do
            migration "create_make_voteable_tables" do
              contains "class CreateMakeVoteableTables"
              contains "create_table :votings"
            end
          end
        end
      }
    end
  end
end