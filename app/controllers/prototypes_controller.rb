class PrototypesController < ApplicationController
before_action :authenticate_user!, only: [:new, :destroy]
before_action :authorize_user!, only: [:edit, :update, :destroy]

def index
  @prototypes = Prototype.includes(:user).all
end

def new
  @prototype = Prototype.new
end

def create
  @prototype = Prototype.new(prototype_params)
  if @prototype.save
   redirect_to root_path, notice: 'Prototype was successfully created.'
   else
   render :new
  end
end

def show
  @prototype = Prototype.includes(:user).find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user)
end

def edit
  @prototype = Prototype.find(params[:id])
end

def update
  prototype = Prototype.find(params[:id])
  if @prototype.update(prototype_params)
  redirect_to prototype_path(@prototype)
  else
    render :edit
  end
end

def destroy
  prototype = Prototype.find(params[:id])
  prototype.destroy
  redirect_to root_path
end

private
def prototype_params
 params.require(:prototype).permit(:title,:catch_copy,:concept,:image).merge(user_id: current_user.id)
end

def authorize_user!
  @prototype = Prototype.find(params[:id])
  unless @prototype.user == current_user
    redirect_to user_session_path
  end
 end
end
