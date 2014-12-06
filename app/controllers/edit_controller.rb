class EditController < ApplicationController
  
  def edit
    # if session doesn't exit, or isn't the current edit code, then go to log in
    if session[:edit_code].blank?
      redirect_to :action => "login", :edit_code => params[:edit_code]
    elsif session[:edit_code] != params[:edit_code]
      redirect_to :action => "login", :edit_code => params[:edit_code]
    else #do actual edit
      @summit = Summit.find_by(:edit_code => params[:edit_code])
      
    end
  end
  
  def login
    
  end
  
  def attempt_login
    if params[:email].present? && params[:edit_code].present?
      if !Summit.exists?(:edit_code => params[:edit_code])
        error
      elsif Summit.find_by(:edit_code => params[:edit_code]).admin_email != params[:email]
        error
      else #successfully logged in
        session[:edit_code] = params[:edit_code]
        redirect_to :action => 'edit', :edit_code => session[:edit_code]
      end
    else
      error
    end
  end
  
  private
    def error
      flash[:error] = "Please try again..."
      render 'login'
    end
  
end
