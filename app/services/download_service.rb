class DownloadService
  def self.find id
    download = Download.where(id: id).first
    raise StandardError, "Cannot find download with ID #{id}" unless download
    
    case download.url
    when /youtube\.com|youtu\.be/
      download = download.to_youtube_dl
    when /magnet\:/
      download = download.to_transmission_cli
    when /drive\.google/
      download = download.to_gdl
    else
      download = download.to_wget
    end

    download
  end

  def initialize(download)
    @download = download
  end

  def perform!
    prep_output_path

    begin
      return if @download.cancelled?
      @download.start!
      system @download.build_command
      @download.finish!
    rescue => e
      @download.error! e.message
    end    
  end

  private

  def prep_output_path
    dir = ENV['OUTPUT_PATH']
    FileUtils.mkdir_p(dir) unless File.exists?(dir)
  end
end
