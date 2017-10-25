class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def my_posts
    puts "**** my_posts ****"
    @my_posts = @current_user.posts
  end

  def profile_posts
    puts "**** profile_posts ****"
    @user = User.find(params[:id])
    @current_posts = @user.posts
  end

  # GET /posts # GET /posts.json
  def index
    @posts = Post.all
    @comments = Comment.all
  end

  # GET /posts/1 # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    puts "**** new post ****"
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    puts "**** edit post ****"
  end

  # POST /posts
  # POST /posts.json
  def create
    puts "**** create post ****"
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to my_posts_path, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
    puts "@current_user: #{@current_user.inspect}"
    puts "@post: #{@post.inspect}"
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_posts_path(@current_user[:id]), notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1 # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_posts_path(@current_user[:id]), notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @current_user[:id]
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      # params.fetch(:post, {})
      params.require(:post).permit(:user_id, :title, :content)
    end
end
