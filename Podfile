source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '15.5'
workspace 'Here'

abstract_target 'EW' do
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
  # EMPTY_WINDOW_FREE_TARGET = 'Empty Window'
  # EMPTY_WINDOW_PAID_TARGET = 'Empty Window Paid'
  EMPTY_WINDOW_CONFIGS_PATH = "Empty Window/Configs/%s.xcconfig"
  EMPTY_WINDOW_PODS_CONFIGS_PATH = "#include \"../../../Pods/Target Support Files/%s/%s.%s.xcconfig\""
  CONFIG_DEBUG = 'Debug'
  CONFIG_RELEASE = 'Release'
  TARGET_FREE = 'Empty Window'
  TARGET_PAID = 'Empty Window Paid'
  PODS_PREFIX = 'Pods-EW-'

  TARGETS_TO_HANDLE = [TARGET_FREE, TARGET_PAID]

  def initialize (config, target)
    @config = config
    @target = target
  end   

  def generate_config_file()
    case @target
    when TARGET_FREE 
      config_file = 'Free'
    when TARGET_PAID
      config_file = 'Paid'
    else
      raise StandardError, "Not supported #{@target}" 
    end
    config_file = config_file + @config.to_s
    return EwScheme::EMPTY_WINDOW_CONFIGS_PATH % config_file
  end

  def generate_pod_config_file_including()
    pods_target = "#{PODS_PREFIX}#{@target}"
    return EwScheme::EMPTY_WINDOW_PODS_CONFIGS_PATH % [pods_target, pods_target, @config.downcase]
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

def set_configurations(empty_window_project, config, config_file_path)
  
  config_file = empty_window_project.new_file(config_file_path)
  config.base_configuration_reference = config_file
      
end

def add_pod_config_file(scheme, config_file_path)
  pod_config_file_including = scheme.generate_pod_config_file_including()
  config_file_full_path = "#{Dir.pwd}/Empty Window/#{config_file_path}"
 
  config_file = File.open(config_file_full_path, 'r+')
  lines = config_file.readlines
  unless lines.any?{ |line| line.strip == pod_config_file_including}
    puts "add pod config including"
    tempt_file_full_path = "#{config_file_full_path}.temp"
    File.open(tempt_file_full_path, 'w') do |temp|
      lines.each do |line|
        if line.include?("#include")
          temp.puts "\n#{pod_config_file_including}"
        end
        temp.puts line
      end
    end
    File.rename(tempt_file_full_path, config_file_full_path)
  end
end

post_install do |installer|
  require 'xcodeproj'
  empty_window_path = 'Empty Window/Empty Window.xcodeproj'
  empty_window_project = Xcodeproj::Project.open(empty_window_path)
  empty_window_project.targets.each do |target|
    target_name = target.name
    next unless EwScheme::TARGETS_TO_HANDLE.include?(target_name)
    target.build_configurations.each do |config|
    scheme = EwScheme.new(config.name, target_name)
      begin
        config_file_path = scheme.generate_config_file()
        add_pod_config_file(scheme, config_file_path)
        set_configurations(empty_window_project, config, config_file_path)
        empty_window_project.save
      rescue Errno::ENOENT => error
        puts "Error: File(#{config_file_path}) not found. "
      rescue StandardError => error
        puts "Error: Not support #{target_name}."
      end
    end
  end
end
