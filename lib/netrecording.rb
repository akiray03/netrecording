require 'netrecording/version'
require 'netrecording/http'
require 'netrecording/http_header'
require 'fakeweb'

module Netrecording
  @@records = []
  @@recording = false

  def self.records
    @@records
  end

  def self.start_recording!
    @@recording = true
  end

  def self.stop_recording!
    @@recording = false
  end

  def self.recording?
    !! @@recording
  end

  def self.save!(file_path = nil)
    unless file_path
      file_path = File.join(Rails.root, 'tmp', 'netrecording', Time.current.strftime("%Y-%m-%d_%H%M%S.yml"))
      FileUtils.mkdir_p(File.dirname file_path) unless File.exist?(File.dirname file_path)
    end

    File.open(file_path, 'w') do |fp|
      fp.puts @@records.to_yaml
    end
    @@records = []

    file_path
  end
end
