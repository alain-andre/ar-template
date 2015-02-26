require "rubygems"
require "bundler/setup"
require "stringex"

desc "Create a new project called test_app if no project name is given"
task :new_project, :project_name do |t, args|
project_name = args.project_name || "test_app"
  FileUtils.cd("..")
  FileUtils.rmdir(project_name)
  puts "Installing project #{project_name} in #{FileUtils.pwd}"
  skip_devise = "--skip-devise" if ask("Do you whant to skip devise installation ?", ['y', 'n']) == 'y'
  system "rails _4.0.0_ new #{project_name} -m ar-template/template.rb --skip-bundle #{skip_devise} --force"
  FileUtils.cd(project_name)
  system "rails g auth_browserid" if ask("Do you whant to generate a auth_browserid ? It will only work if you axcepted devise installation.", ['y', 'n']) == 'y'
  system "rails generate angular_scaffold compte nom:string description:text prix:decimal rdv:date validation:boolean heure:time creation:datetime" if ask("Do you whant to generate an angular_scaffold compte example ?", ['y', 'n']) == 'y'
end

private
  def get_stdin(message)
    print message
    STDIN.gets.chomp
  end

  def ask(message, valid_options)
    if valid_options
      answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
    else
      answer = get_stdin(message)
    end
    answer
  end