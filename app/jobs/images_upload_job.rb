class ImagesUploadJob < ApplicationJob
  queue_as :default

  def perform(image)
    # Do something later
    #Image.create(image)
    
  end

end
