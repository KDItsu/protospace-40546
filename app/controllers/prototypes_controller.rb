class PrototypesController < ApplicationController

  # before_action :move_to_index, except: [:edit, :update, :destroy]
  before_action :set_prototype,  except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]


  def index #緑色はモデル名
    @prototypes = Prototype.all.includes(:user)
  end

  def new #入力ページ
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render:new, status: :unprocessable_entity
    end
  end
  
  def show #詳細ページに必要なもの
    @comment = Comment.new #コメントの作成
    @comments = @prototype.comments.includes(:user) #prototypeテーブルの情報
  end

  def edit
    # @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect to root_path
    end
  end
  

  def update
    # @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      @prototypes = Prototype.includes(:user)
      render:edit, status: :unprocessable_entity
    end
  end

  def destroy
    # @prototype = Prototype.find(params[:id])
    if@prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end


  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :profile, :occupation, :position).merge(user_id: current_user.id)
  end

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def contributor_confirmation
    redirect_to root_path unless current_user.id == @prototype.user.id
  end

  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to user_path
  #   end
  # end
end
