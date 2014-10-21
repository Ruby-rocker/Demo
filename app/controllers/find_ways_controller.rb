class FindWaysController < ApplicationController
  before_action :authenticate_admin!

  def index
    @locations = Location.all.active
  end

  def find_a_way
    render :partial => 'find_a_way'
  end

  def create_way
    @store = (Store.find(params[:image_form][:store_id]) rescue "") if params[:image_form][:store_id]
    if @store && params[:image_form][:uploaded_data]
      @attachment_store = AttachmentStore.find_by_store_id(params[:image_form][:store_id])#.destroy
      @attachment_store.destroy if @attachment_store
      @attachment_store.save if @attachment_store

      @storeattachment = @store.attachments
      @storeattachment.destroy_all if @storeattachment.count > 0

      @attachment = @store.attachments.create()
      @attachment.attachment = params[:image_form][:uploaded_data]
      @attachment.save

      AttachmentStore.create(:store_id => params[:image_form][:store_id], :attachment_id => @attachment.id)
    end
    redirect_to find_ways_path
  end
end
