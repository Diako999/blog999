class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_current_user, only: [:edit, :destroy, :update]

  def show

  end
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
  def new
    @article = Article.new
  end
  def create
    @article = Article.new(white_list)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article Was Addded Successfully!!!"
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit

  end
  def update

    if @article.update(white_list)
      flash[:notice] = "Article was updated successfuly"
      redirect_to @article
    else
      render 'edit'
    end

  end
  def destroy

    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
  end
  def white_list
    params.require(:article).permit(:title, :description)
  end
  def require_same_current_user
    if current_user != @article.user && !current_user.admin
      flash[:alert] = "you can only edit your own articles"
      redirect_to @article
    end
  end
end
