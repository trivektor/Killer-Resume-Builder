class AjaxController < ApplicationController
  
  def sort_resume_sections
    sections = {
      1 => "personal_information",
      2 => "education",
      3 => "skills",
      4 => "references",
      5 => "field_works",
      6 => "keywords"
    }
    ids = params[:id]
    resume_id = params[:resume_id]
    section_orders = []
    
    for id in ids
      section_orders.push(sections[id])
    end
    
    resume_section_order = ResumeSectionOrder.find_by_resume_id(resume_id)
    resume_section_order.update_attributes(:orders => section_orders.join("/"))
    
  end
  
end
