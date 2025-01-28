class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.prototype_id = params[:prototype_id] 
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to prototype_path(@comment.prototype)
      else
      render "prototypes/show"
     end
  end

private
def comment_params
  params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
 end
end
