types=[:audio,:video,:torrent]
no_types = types.count
audio_formats = ["best", "aac", "flac", "mp3", "m4a", "opus", "vorbis", "wav"]
no_audio_formats = audio_formats.count

user = User.first
user.downloads.destroy_all
10.times do 
  Download::VALID_STATUSES.each do |state|
    data = {
      url: Faker::Internet.url,
      status: state
    }
    type = types[rand(no_types)]
    case state
    when Download::STATUS_QUEUED
      data[:queued_at] = DateTime.now - rand(100).hours
    when Download::STATUS_STARTED
      data[:queued_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:queued_at] + 1.hour
    when Download::STATUS_FINISHED
      data[:queued_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:queued_at] + 1.hour
      data[:finished_at] = data[:started_at] + rand(10).minutes
    when Download::STATUS_ERROR
      data[:queued_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:queued_at] + 1.hour
      data[:finished_at] = data[:started_at] + rand(10).minutes
      data[:error] = Faker::Quote.famous_last_words
    when Download::STATUS_CANCELLED
      data[:queued_at] = DateTime.now - rand(100).hours
      data[:started_at] = data[:queued_at] + 1.hour
      data[:cancelled_at] = data[:started_at] + rand(10).minutes
    end

    # http auth
    if rand(10) == 0
      data[:http_username] = Faker::Alphanumeric.alphanumeric(number: 15)
      data[:http_password] = Faker::Alphanumeric.alphanumeric(number: 15)
    end

    # file_filter
    if rand(10) == 0
      data[:file_filter] = "*#{Faker::Alphanumeric.alphanumeric(number: 5)}*"
    end

    if type == :audio
      data[:audio_only] = true
      data[:audio_format] = audio_formats[rand(no_audio_formats)]
    end

    # download_subs
    if rand(20) == 0
      data[:download_subs] = true
      data[:srt_subs] = rand(10) == 0
    end

    user.downloads.create! data
  end
end