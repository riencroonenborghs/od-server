module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :downloads, [DownloadType], null: false

    def downloads
      context[:current_user].downloads
    end
  end
end
