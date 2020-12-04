class DownloadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    download = DownloadService.find args.first
    raise StandardError, "Cannot find download with ID #{args.first}" unless download

    service = DownloadService.new download
    service.perform!
  end
end
