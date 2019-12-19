class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]
 
  def new
    @group = Group.new
  end

  def create
    Group.create(group_params)
    @group.save
    redirect_to root_path
  end

  def edit
  end

  def update
    Group.update(group_params)
    redirect_to root_path
  end

  private
  def group_params
    params
      .require(:group).permit(Group::name + Groups_user::user)
  end
 
  def set_group
    group = Group.find(params[:id])
  end
end
