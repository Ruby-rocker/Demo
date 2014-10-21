class TemplateMastersController < ApplicationController
  before_action :authenticate_admin!

  before_action :set_template_master, only: [:show, :edit, :update, :destroy]
  # GET /template_masters
  # GET /template_masters.json
  def index
    @template_masters = TemplateMaster.all.sorted(params[:sort])
  end

  # GET /template_masters/1
  # GET /template_masters/1.json
  def show
    @image = @template_master.images(@template_master.id)
  end

  # GET /template_masters/new
  def new
    @template_master = TemplateMaster.new
  end

  # GET /template_masters/1/edit
  def edit
    @image = @template_master.images(@template_master.id)
  end

  # POST /template_masters
  # POST /template_masters.json
  def create
    @template_master = TemplateMaster.new(template_master_params)

    respond_to do |format|
      if @template_master.save
        if params[:template_master][:attachment] || params[:template_master][:attachment_icon]
          @template_attachment = @template_master.attachments.create()
          @template_attachment.attachment = params[:template_master][:attachment] if params[:template_master][:attachment]
          @template_attachment.attachment_icon = params[:template_master][:attachment_icon] if params[:template_master][:attachment_icon]
          @template_attachment.save
        end

        AdminTemplateMaster.create(:template_master_id => @template_master.id, :admin_id => current_admin.id)

        format.html { redirect_to template_masters_path, notice: 'Template master was successfully created.' }
        format.json { render :index, status: :created, location: @template_master }
      else
        format.html { render :new }
        format.json { render json: @template_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /template_masters/1
  # PATCH/PUT /template_masters/1.json
  def update
    #abort params[:template_master][:attachment_icon].inspect
    respond_to do |format|
      if @template_master.update(template_master_params)
        if params[:template_master][:attachment] || params[:template_master][:attachment_icon]
          if @template_master.attachments && @template_master.attachments.count > 0
            @template_master.attachments[0].attachment = params[:template_master][:attachment] if params[:template_master][:attachment]
            @template_master.attachments[0].attachment_icon = params[:template_master][:attachment_icon] if params[:template_master][:attachment_icon]
            @template_master.attachments[0].save
          else
            @template_attachment = @template_master.attachments.create()
            @template_attachment.attachment = params[:template_master][:attachment] if params[:template_master][:attachment]
            @template_attachment.attachment_icon = params[:template_master][:attachment_icon] if params[:template_master][:attachment_icon]
            @template_attachment.save
          end
        end
        if @template_master.admin_template_masters.count == 0
          AdminTemplateMaster.create(:template_master_id => @template_master.id, :admin_id => current_admin.id)
        end
        format.html { redirect_to template_masters_path, notice: 'Template master was successfully updated.' }
        format.json { render :index, status: :ok, location: @template_master }
      else
        format.html { render :edit }
        format.json { render json: @template_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /template_masters/1
  # DELETE /template_masters/1.json
  def destroy
    @template_master.destroy
    respond_to do |format|
      format.html { redirect_to template_masters_url, notice: 'Template master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_multiple_template
    params[:template_master][:chk_ids].each do |idx, val|
      if val=='1'
        @template = TemplateMaster.find(idx)
        if params[:template_master][:name] == "delete"
          @template.admin_template_masters.destroy_all if @template.admin_template_masters rescue ""
          @template.campaign_template_masters.destroy_all if @template.campaign_template_masters rescue ""
          @template.attachments.destroy_all if @template.attachments rescue ""
          @template.destroy
        else
          @template.is_active = (@template.is_active?)? false : true
          @template.save
        end
      end
    end
    respond_to do |format|
      format.html { redirect_to template_masters_url, notice: 'Template Masters were successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template_master
      @template_master = TemplateMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_master_params
      params.require(:template_master).permit(:name, :description,:amount,:coupon_code, :header_text, :is_active, attachments_attributes: [:attachment, :attachment_icon])
    end
end
