module Types
  class DownloadType < Types::BaseObject
    field :user, UserType, null: true, method: :user
    field :id, ID, null: false
    field :url, String, null: false
    field :status, String, null: true
    field :http_username, String, null: true
    field :http_password, String, null: true
    field :queued_at, GraphQL::Types::ISO8601DateTime, null: true
    field :started_at, GraphQL::Types::ISO8601DateTime, null: true
    field :finished_at, GraphQL::Types::ISO8601DateTime, null: true
    field :error, String, null: true
    field :cancelled_at, GraphQL::Types::ISO8601DateTime, null: true
    field :file_filter, String, null: true
    field :audio_only, Boolean, null: true
    field :audio_format, String, null: true
    field :download_subs, Boolean, null: true
    field :srt_subs, Boolean, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
