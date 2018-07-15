class ReviewsController < ApplicationController
    before_action :logged_in?, only: [:new, :create, :edit, :update, :delete]

  def new
    @review = Review.new
  end

  def create
    if !logged_in?
      flash[:notice] = "Must be signed in to create review"
      redirect_to root_path
    elsif is_admin?
      flash[:notice] = "Admin can't create reviews!"
      redirect_to root_path
    elsif params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @review = @user.reviews.build(review_params)
      @review.save
    redirect_to reviews_path
  else
      @user = User.find_by(id: session[:user_id])
      @review = @user.reviews.build(review_params)
      @review.save
    redirect_to reviews_path
  end
end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    @review = Review.find_by(user_id: params[:user_id])
    if !is_admin? && current_user == @review.user
      render 'edit'
    else
      flash[:notice] = "You can't edit this review!"
      redirect_to reviews_path
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    @user = @review.user
    redirect_to user_path(@user)
  end

  def index
    # binding.pry
    if params[:user_id]
      @reviews = User.find(params[:user_id]).reviews
   else
      @reviews = Review.all
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if !is_admin && current_user
      @review.destroy
      redirect_to reviews_path
    else
      flash[:notice] = "You can't delete this review!"
  end
end


  private

  def review_params
    params.require(:review).permit(:title, :comment, :date_posted, :user_id)
  end
end