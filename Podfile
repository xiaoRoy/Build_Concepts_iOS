source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.5'
workspace 'Here'

  use_frameworks!
  project 'Empty Window/Empty Window.xcodeproj'
  pod 'SnapKit', '~> 5.7.0'

  target 'Empty Window' do
    # Comment the next line if you don't want to use dynamic frameworks
  
    # Pods for Empty Window
  
    target 'Empty Window Tests' do
      inherit! :search_paths
      # Pods for testing
    end
  
  end
  
  target 'Empty Window Paid' do

  
    # Pods for Empty Window Paid
  
  end
  
end

class EwScheme
  def initialize (config, target)
    @config = config
    @target = target
  end

  def generate_config_file()
    
  end


end

EMPTY_WINDOW_FREE_TARGET = 'Empty Window'
EMPTY_WINDOW_PAID_TARGET = 'Empty Window Paid'
def generate_config_files_mapping()
  empty_window_configs_folder = "Empty Window/Configs/%s.xcconfig"
  config_debug = 'Debug'
  config_release = 'Release'
  target_free = 'Empty Window'
  target_paid = 'Empty Window Paid'
  return { 
    "#{config_debug}:#{EMPTY_WINDOW_FREE_TARGET}" => empty_window_configs_folder % 'FreeDebug',
    "#{config_debug}:#{EMPTY_WINDOW_PAID_TARGET}" => empty_window_configs_folder % 'PaidDebug',
    "#{config_release}:#{EMPTY_WINDOW_FREE_TARGET}" => empty_window_configs_folder % 'FreeRelease',
    "#{config_release}:#{EMPTY_WINDOW_PAID_TARGET}" => empty_window_configs_folder % 'PaidRelease',
  }
end

post_install do |installer|
  require 'xcodeproj'
  configs_files = generate_config_files_mapping()
  empty_window_path = 'Empty Window/Empty Window.xcodeproj'
  empty_window_project = Xcodeproj::Project.open(empty_window_path)
  empty_window_project.targets.each do |target|
    next unless [EMPTY_WINDOW_FREE_TARGET, EMPTY_WINDOW_PAID_TARGET].include?(target.name)
    target.build_configurations.each do |config|
      config_and_target = "#{config.name}:#{target.name}"
      begin
        config_file_path = configs_files.fetch(config_and_target)
        config_file = empty_window_project.new_file(config_file_path)
        config.base_configuration_reference = config_file
        empty_window_project.save
      rescue KeyError => error
          puts "Error: Key '#{config_and_target}' mapping config file not found. "
      end 
    end
  end
  
end
