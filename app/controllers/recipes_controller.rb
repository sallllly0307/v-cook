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
        user_id: @current_user.id
    )
    @recipe.save

    @ingredient = Ingredient.new(
        recipe_id: @recipe.id,
        name: params[:name],
        quantity: params[:quantity],
    )

    @ingredient.save

    @step = Step.new(
        recipe_id: @recipe.id,
        step: params[:step]
    )

    if @step.save
      @user = @recipe.user
      redirect_to("/users/#{@user.id}")
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


end
