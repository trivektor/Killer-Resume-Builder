class ResumeReferencesController < ApplicationController
  
  include ResumeHelper
  
  before_filter :require_user, :verify_ownership
    
  def new
    @resume_reference = ResumeReference.new
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'references').first
    
    @section_name = section_order.name
  end
  
  def create
    @resume_reference = ResumeReference.new(params[:resume_reference])
    @resume_reference.resume_id = params[:resume_id]
    if @resume_reference.save
      redirect_to edit_resume_path(@resume)
    else
      render :action => :new
    end
  end
  
  def edit
    @resume_reference = find_resume_reference
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'references').first
    
    @section_name = section_order.name
  end
  
  def update
    @resume_reference = find_resume_reference
    if @resume_reference.update_attributes(params[:resume_reference])
      flash[:notice] = "Reference has been updated"
      redirect_to edit_resume_resume_reference_path(@resume)
    else
      render :action => :edit
    end
  end
  
  def delete
    ResumeReference.delete(params[:id])
    redirect_to edit_resume_path(@resume)
  end
  
  def order
    
    orders = params[:order]
    
    weight = orders.count
    
    i = 0
    
    for id in orders
      ref = ResumeReference.where(:resume_id => params[:resume_id], :id => id).first
      ref.update_attributes(:weight => weight)
      weight -= 1
    end
    
    render :json => {:success => 1}
    
  end
  
  private
  
  def find_resume_reference
    ResumeReference.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
end
