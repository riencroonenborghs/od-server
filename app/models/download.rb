class Download < ApplicationRecord
  STATUS_INITIAL    = "initial"
  STATUS_QUEUED     = "queued"
  STATUS_STARTED    = "started"
  STATUS_FINISHED   = "finished"
  STATUS_ERROR      = "error"
  STATUS_CANCELLED  = "cancelled"
  VALID_STATUSES    = [STATUS_INITIAL, STATUS_QUEUED, STATUS_STARTED, STATUS_FINISHED, STATUS_ERROR, STATUS_CANCELLED]

  belongs_to :user

  validates_presence_of :url
  validates_inclusion_of :status, in: VALID_STATUSES
  validates_inclusion_of :audio_format, in: ["best", "aac", "flac", "mp3", "m4a", "opus", "vorbis", "wav"]
  validate :http_credentials

  def self.for_clearing
    where(status: [STATUS_FINISHED, STATUS_ERROR, STATUS_CANCELLED])
  end

  def enqueue!    
    return if queued? || started?
    DownloadJob.perform_later self.id
    queue!
  end

  def queue!
    update(status: STATUS_QUEUED, queued_at: Time.zone.now, started_at: nil, finished_at: nil, error: nil)
  end

  def start!    
    update(status: STATUS_STARTED, started_at: Time.zone.now, finished_at: nil, error: nil)
  end

  def finish!
    update(status: STATUS_FINISHED, finished_at: Time.zone.now)
  end

  def error!(message)
    update(status: STATUS_ERROR, finished_at: Time.zone.now, error: message)
  end

  def cancel!
    update(status: STATUS_CANCELLED, cancelled_at: Time.zone.now)
  end

  def reload_proper!
    DownloadService.find self.id
  end

  def queued?
    status == STATUS_QUEUED
  end

  def started?
    status == STATUS_STARTED
  end

  def cancelled?
    status == STATUS_CANCELLED
  end

  def to_youtube_dl
    Download::YoutubeDl.find self.id
  end

  def to_transmission_cli
    Download::TransmissionsCLi.find self.id
  end

  def to_wget
    Download::Wget.find self.id
  end

  private

  def http_credentials
    errors.add(:http_username, "no HTTP password set") if http_username.present? && !http_password.present?
    errors.add(:http_password, "no HTTP username set") if http_password.present? && !http_username.present?
  end
end
