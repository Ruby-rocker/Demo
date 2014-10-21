class PushConfigurationsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @push_config = Push::ConfigurationApns.last
  end

  def update_configuration
    params.permit!
    if (params[:push_configuration_apns] || params[:certificate])
      @push_config = Push::ConfigurationApns.last.id
      @push_config_apns = Push::ConfigurationApns.find(@push_config)

      if params[:certificate]
        @push_attachments = Attachment.find_by_attachable_type("Push::ConfigurationApns") rescue nil

        @attachment = Attachment.create!(:attachable_id => @push_config, :attachable_type => 'Push::ConfigurationApns')
        @attachment.pem_certi = params[:certificate]
        @attachment.save!

        @pem_certi_path = @attachment.pem_certi.path

        @push_config_apns.update_attributes(certificate: File.read(@pem_certi_path))
      end

      params[:push_configuration_apns][:sandbox] = (params[:push_configuration_apns][:sandbox] == "1" || params[:push_configuration_apns][:sandbox] == 1 || params[:push_configuration_apns][:sandbox] == true) ? true : false
      @push_config_apns.update(params[:push_configuration_apns])

      redirect_to push_configurations_path
    end
  end

  private

  def push_configuration_apns_params
    params.require(:push_configuration_apns).permit(:app, :certificate, :feedback_poll, :sandbox, attachments_attributes: [:pem_certi])
  end

end
