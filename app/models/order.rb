class Order < ActiveRecord::Base
  #Search
  include PgSearch
  pg_search_scope :search_items, :against => [:id, :created_at]

  #Enum
  #STATUS = { "New" => 1 , "Admin Approved/Waiting for review" => 2, "Admin rejected" => 3, "Reviewed" => 4, "Review approved" => 5, "Review rejected" => 6, "In review" => 7 }
  STATUS = { "Pending" => 1 , "Admin Approved" => 2, "Admin rejected" => 3, "Reviewed" => 4, "Review approved" => 5, "Review rejected" => 6, "In review" => 7 }

  #after_create :send_admin_reviewer_mail

  #associations
  belongs_to :user
  has_many :videos, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :payment, dependent: :destroy

  #validations
  validates :title, :presence => true

  #Nested attributes
  accepts_nested_attributes_for :videos, allow_destroy: true

  #send mail to reviewer and admin for new video create
  def self.send_admin_reviewer_mail(order)
    @order = order
    logger.warn("=-=-=-=-=-=-=-=-=-=--=-= #{@order.user.inspect}")
    # @users = User.not_user
    # @users.each do |user|
    #   OrderMailer.send_new_order_message(@order,user).deliver_now
    # end

    @admin_users = User.is_admin
    @admin_users.each do |user|
      OrderMailer.send_new_order_mail_to_admin(@order,user).deliver_now
    end

    @reviewer_users = User.is_reviewer
    @reviewer_users.each do |user|
      OrderMailer.send_new_order_mail_to_reviewer(@order,user).deliver_now
    end

    currentUser = order.try(:user_id)
    if currentUser.present?
      @user = User.find(currentUser.to_i)
      OrderMailer.send_new_order_mail_to_user(@order,@user).deliver_now
    end
  end

end
