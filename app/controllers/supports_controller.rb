# app/controller/supports_controller.rb
class SupportsController < ApplicationController
  def new
    # id is required to deal with form
    @support = Support.new(:id => 1)
  end
  
 
 
  def create
    @support = Support.new(params[:support])
    
    if @support.save
      redirect_to(request.referer,:notice => "Mail sent") 
    else
      redirect_to(request.referer, :notice => "Error while sending mail")
    end
  end
end


