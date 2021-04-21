class Admin::GenresController < ApplicationController
   before_action :authenticate_admin!, except: [:show]

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(10)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
       flash[:notice] = "ジャンルを追加しました"
       redirect_to admin_genres_path
    else
      @genres = Genre.all.page(params[:page]).per(10)
      render :index and return
    end
  end

  def show
    @products = Product.all.all.page(params[:page]).per(10)
    @genre = Genre.find(params[:id])
    @genres = @genre.products.order(created_at: :desc).all.page(params[:page]).per(5)
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
       flash[:notice] = "You have update Genre successfully"
       redirect_to admin_genres_path
    else
       render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_valid)
  end
end
