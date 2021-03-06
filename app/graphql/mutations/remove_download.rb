module Mutations
  class RemoveDownload < BaseMutation
    # arguments passed to the `resolve` method
    argument :id, ID, required: true

    # return type from the mutation
    type Boolean

    def resolve(id:)
      download = context[:current_user].downloads.find(id)      
      download.destroy
    end
  end
end