class FamilynameController < ApplicationController

  def new
    @page_title = 'Create new Family Name'
    @familyname = Familyname.new
    
  end

  def create
    @familyname = Familyname.new(params[:familyname])
    if @familyname.save
      flash[:notice] = "New family name #{@familyname.name} was created successfully"
      redirect_to :action => 'index'
    else
      @page_title = 'Create New Family Name'
      render :action => 'new'
    end
  end

  def edit
    @page_title = 'Edit a Family Name'
  end

  def update
  end

  def destroy
    @familyname = Familyname.find(params[:id])
    flash[:notice] = "Successfully deleted Name #{@familyname.name}"
    @familyname.destroy
    redirect_to :action => 'index'
  end

  def show
    @familyname = Familyname.find(params[:id])
    @page_title = @familyname.name
  end

  def index
    @page_title = 'List All Family Names'
    @familynames = Familyname.find(:all)
  end
end
