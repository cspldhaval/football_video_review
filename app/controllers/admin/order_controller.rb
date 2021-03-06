class Admin::OrderController < Admin::BaseController
  before_action :authenticate_user!
  before_action :set_order, :only => [:show,:order_details]

  def index
    @orders = Order.where(:status => Order::STATUS["Pending"])
  end

  def reviewed_videos
    order_ids = Review.where("user_id =?", current_user.id).pluck(:order_id).uniq
    @orders = Order.where("id IN (?)", order_ids)
  end

  def show
    @review = Review.new
  end

  def reviewed_by_reviewer
    page = 10
    if params[:per_page].present?
      page = params[:per_page]
    end
    @orders = Order.where(:status => Order::STATUS["Reviewed"]).page(params[:page]).per(page)
    if params[:search].present?
      # @orders = @orders.search_items(params[:search])
      @orders = @orders.where("lower(title) like ?", "%"+params[:search]+"%".downcase)
    end
  end

  # if admin approve or reject any order then order status will be updated
  def approval_of_admin
    status = params[:status]
    @order = Order.find(params[:id])
    @order.update_attributes!(:status => status)
    @order_email = Order.find(params[:id])
    if status == "5"
      @reviewer = @order.reviews.last.user
      OrderMailer.admin_review_approved(@order_email, @reviewer).deliver_now
    elsif status == "6"
      @reviewer = @order.reviews.last.user
      OrderMailer.admin_review_rejected(@order_email,@reviewer).deliver_now
      user = User.find(@order.user_id)
      user_orders_count = user.orders.count
      if user_orders_count == 1
        @order.update_attributes!(:status => 7)
      end
    end
    redirect_to admin_reviewed_by_reviewer_path , :notice => "Order successfully updated."
  end

  #List of orders
  def list_of_orders
    page = 10
    if params[:per_page].present?
      page = params[:per_page]
    end
    @orders = Order.joins(:user).where("payment_status =?", "paid")
    @orders = @orders.page(params[:page]).per(page).order("orders.created_at ASC")
    if params[:search].present?
      # @orders = @orders.search_items(params[:search])
      @orders = @orders.where('lower(users.first_name) like ? or lower(users.last_name) like ?', "%"+params[:search]+"%", "%"+params[:search]+"%").order("orders.created_at ASC")
    end
  end

  def order_details
    @review = Review.joins(:user).where("reviews.order_id =? and users.user_type = ?", @order.id, 2).last
    if !@review.present?
      @review = Review.joins(:user).where("reviews.order_id =? and users.user_type = ?", @order.id, 1).first
    end
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

end
