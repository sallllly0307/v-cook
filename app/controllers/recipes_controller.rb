class RecipesController < ApplicationController
  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @recipes = Recipe.all.order(created_at: :desc)
    @ranks = Recipe.find(Like.group(:recipe_id).order('count(recipe_id) desc').limit(3).pluck(:recipe_id))
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @user = @recipe.user
    @likes_count = Like.where(recipe_id: @recipe.id).count
  end

  def new

  end

  def create
    @recipe = Recipe.new(
        title: params[:title],
        comment: params[:comment],
        category: params[:category],
        minutes: params[:minutes],
        user_id: @current_user.id
    )

    @recipe.save

    #zipメソッドで複数の配列から同時に変数を取り出している
    params[:name].zip(params[:quantity], params[:step]).each do |name, quantity, step|
      ingredient = Ingredient.new(
          recipe_id: @recipe.id,
          name: name,
          quantity: quantity
      )
      ingredient.save
      steps = Step.new(
          recipe_id: @recipe.id,
          step: step
      )
      steps.save
    end

    #応急処置　ifの条件をキレイにする必要がある
    if @recipe.title != "null"
      @user = @recipe.user
      redirect_to("/users/#{@user.id}")
    else
      render("recipes/new")
    end


  end

  def edit
    @recipe = Recipe.find_by(id: params[:id])
  end

  def update
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.title = params[:title]
    @recipe.comment = params[:comment]
    if @recipe.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/recipes/index")
    else
      render("recipes/edit")
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @recipe.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/recipes/index")
  end

  def ensure_correct_user
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/recipes/index")
    end
  end

  def searchIndex
    if params[:title]
      @recipes = Recipe.titleSearch(params[:title])
    elsif params[:name]
      @ingredients = Ingredient.nameSearch(params[:name])
    elsif params[:category]
      @recipes = Recipe.where(category: params[:category])
    else
      @recipes = Recipe.all
    end
  end

end
