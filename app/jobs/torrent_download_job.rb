class TorrentDownloadJob < ApplicationJob
  queue_as :torrents

  def perform(*args)
    download = DownloadrService.find args.first
    raise StandardError, "Cannot find download with ID #{args.first}" unless download

    service = DownloadrService.new download
    service.perform!
  end
end
