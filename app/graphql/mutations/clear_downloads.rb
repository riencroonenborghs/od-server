module Mutations
  class ClearDownloads < BaseMutation
    # arguments passed to the `resolve` method
    # argument :id, ID, required: true
    # null true

    # return type from the mutation
    type [ID]

    def resolve
      scope = context[:current_user].downloads.for_clearing
      ids = scope.pluck(:id)
      scope.map(&:destroy)
      ids
    end
  end
end