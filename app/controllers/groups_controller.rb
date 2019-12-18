class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update]
 
  def new
    @group = Group.new
  end

  def create
    Group.create(group_params)
  end

  def edit
  end

  def update
    group.update(group_params)
  end

  private
  def group_params
    params.require(:group).permit(:name)
  end
 
  def set_group
    group = Group.find(params[:id])
  end
end
