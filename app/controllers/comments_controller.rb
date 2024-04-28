class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params)
    redirect_to "/prototypes/#{@comment.prototype.id}"
  end
    # redirect_to "/prototypes/#{comment.prototype.id}"
    # if @comment.save
    #   redirect_to prototype_path(@comment.prototype) # 今回の実装には関係ありませんが、このようにPrefixでパスを指定することが望ましいです。
    # else
    #   @prototype = @comment.prototype
    #   @comments = @prototype.comments
    #   render "prototypes/show" # views/tweets/show.html.erbのファイルを参照しています。
    # end
  

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
