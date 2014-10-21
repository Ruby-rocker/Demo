class MobileApisController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def campaign_image
    @ibeacon = (Ibeacon.find_by_major_id_and_minor_id(params[:major], params[:minor]) rescue nil)

    @beacon_range = (BeaconRange.find_by_range(params[:range]) rescue nil)

    @campaign = (@ibeacon.campaigns.joins({beacon_ranges: :campaign_beacon_ranges}).where('campaigns.is_active = ?', true).uniq rescue nil)
    @campaign = (@campaign.where('beacon_ranges.id = ?', @beacon_range.id) rescue nil) if @beacon_range && @campaign

    @campaign = @campaign.last if @campaign

    @template = (TemplateMaster.find(@campaign.campaign_template_masters[0].template_master_id) rescue nil)
    @attachment = @template.images(@template.id) if @template

    if @attachment
      render :json => {:status => @attachment.attachment(:original)}
    else
      render :json => {:status => "Failure"}
    end
  end

  def attachment_url
    @attachment = (Attachment.find(params[:attachment_id]) rescue nil)
    if @attachment
      render :json => {:status => @attachment.attachment(:original)}
    else
      render :json => {:status => "Failure"}
    end
  end

  def get_beacons_and_campaigns
    @locations = Location.near([params[:latitude], params[:longitude]], 1) rescue nil

    if @locations
      @locations.each do |location|
        @beacons = Ibeacon.active.joins(store: :location).where("locations.id = ?",location.id)
        @beacon_ids = Array.new
        @beacons.each do |ibeacon|
          @one_beacon = @ibeacon_id = Array.new
          @campaigns = ibeacon.campaigns

          @attachments = Array.new
          @campaigns.each do |campaign|
            @template = (TemplateMaster.find(campaign.campaign_template_masters[0].template_master_id) rescue nil)
            @attachment = (@template.images(@template.id) rescue nil) if @template
            @attachments << @attachment.attachment if @attachment
          end

          Push::MessageApns.create(
          app: 'pushtest',
          device: params[:udid],
          alert: (ibeacon.name rescue "no beacon"),
          sound: nil,
          badge: ibeacon.id,
          expiry: 1.day.to_i,
          attributes_for_device: {key: 'MSG'})
          @beacon_ids << {:beacon_name => ibeacon.name, :beacon_description => ibeacon.description, :beacon_uuid => ibeacon.uuid, :beacon_major => ibeacon.major_id, :beacon_minor => ibeacon.minor_id, :attachments => @attachments}
        end
      end
      if @beacon_ids
        render :json => {:status => "Success", :beacon_ids => @beacon_ids}
      else
        render :json => {:status => "False"}
      end
    else
      render :json => {:status => "No location found"}
    end
  end

end
