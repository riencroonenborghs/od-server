module Mutations
  class CreateDownload < BaseMutation
    null true
    
    # arguments passed to the `resolve` method
    argument :url, String, required: true
    argument :http_username, String, required: false
    argument :http_password, String, required: false
    argument :file_filter, String, required: false
    argument :audio_only, Boolean, required: false
    argument :audio_format, String, required: false
    argument :download_subs, Boolean, required: false
    argument :srt_subs, Boolean, required: false

    # return type from the mutation
    type Types::DownloadType

    def resolve(url:, http_username: nil, http_password: nil, file_filter: nil, audio_only: false, audio_format: nil, download_subs: false, srt_subs: nil)
      download = context[:current_user].downloads.build(
        url:            url,
        http_username:  http_username,
        http_password:  http_password,
        file_filter:    file_filter
      )
      download.audio_only     = audio_only    if audio_only
      download.audio_format   = audio_format  if audio_format
      download.download_subs  = download_subs if download_subs
      download.srt_subs       = srt_subs      if srt_subs
      download.save!
      download = download.reload_proper!
      download.enqueue!
      download
    end
  end
end