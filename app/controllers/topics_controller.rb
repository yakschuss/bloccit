class TopicsController < ApplicationController

  def index
    @topics = Topic.visible_to(current_user)
  end

  def show
    @topic = Topic.find(params[:id])

    unless @topic.public || current_user
      flash[:error] = "You must be signed in to view private topics."
      redirect_to new_session_path
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)


      if @topic.save
        @topic.labels = Label.update_labels(params[:topic][:labels])
        redirect_to @topic, notice: "The topic was saved successfully."
      else
        flash[:error] = "There was an issue saving your topic. Please try again"
        render :new
      end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find (params[:id])
    @topic.assign_attributes(topic_params)

    if @topic.save
      @topic.labels = Label.update_labels(params[:topic][:labels])
      flash[:notice] = "Topic was updated"
      redirect_to @topic
    else
      flash[:error] = "Error saving topic, please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    if @topic.destroy
      flash[:notice] = "\"#{@topic.name}\" was deleted successfully."
      redirect_to action: :index
    else
      flash[:error] = "There was an issue deleting the topic. Please try again."
      render :show
    end
  end

  before_action :require_sign_in, except: [:index, :show]

  before_action :authorize_user, except: [:index, :show]

  private

  def topic_params
    params.require(:topic).permit(:name, :description, :public)
  end

  def authorize_user
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to topics_path
    end
  end


end
