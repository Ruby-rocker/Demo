class Attachment < ActiveRecord::Base
  belongs_to :attachable, :polymorphic => true

  has_attached_file :attachment, :styles => { :thumb => "267x214!", :small => "170x93!" }
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  has_attached_file :attachment_icon, :styles => { :thumb => "267x214!", :small => "170x93!" }
  validates_attachment :attachment_icon, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  has_attached_file :attachment_audio
  validates_attachment :attachment_audio, content_type: { content_type: ["audio/mp3", "audio/mpeg"] }

  has_attached_file :pem_certi

end
