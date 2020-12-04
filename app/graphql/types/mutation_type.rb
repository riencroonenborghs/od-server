module Types
  class MutationType < Types::BaseObject
    field :create_download, mutation: Mutations::CreateDownload
    field :remove_download, mutation: Mutations::RemoveDownload
    field :cancel_download, mutation: Mutations::CancelDownload
    field :queue_download, mutation: Mutations::QueueDownload
    field :clear_downloads, mutation: Mutations::ClearDownloads
    field :sign_in_user, mutation: Mutations::SignInUser
  end
end
