class SummitsController < ApplicationController
  before_action :set_summit, only: [:show, :edit, :update, :destroy]

  # GET /summits
  # GET /summits.json
  def index
    @summits = Summit.where(:published => true).order(:date_start)
  end

  # GET /summits/1
  # GET /summits/1.json
  def show
  end

  # GET /summits/new
  def new
    redirect_to :action => :new_public
    #@summit = Summit.new
  end
  
  def new_public
    @summit = Summit.new
  end
  
  def new_private
    if params[:email].present?
      @summit = Summit.new

      @summit.admin_email = params[:email]

      #generate edit code
      @summit.edit_code = "1234"

      if @summit.save
        send_edit_code(params[:email], @summit.edit_code)
        session[:edit_code] = @summit.edit_code
        redirect_to :controller => "edit", :action => "edit", :edit_code => @summit.edit_code
      else
        flash[:error] = "Please enter a valid e-mail address"
        render 'new'
      end
    else
      flash[:error] = "Please enter a valid e-mail address"
      render 'new'
    end
  end

  # GET /summits/1/edit
  def edit
    render 'edit/edit'
  end

  # POST /summits
  # POST /summits.json
  def create
    @summit = Summit.new(summit_params)
    
    @summit.currency = "$"
    @summit.location_country = "USA"
    
    @summit.deadline = create_deadline_json
    @summit.admin_email = ""
    
    respond_to do |format|
      if @summit.save
        format.html { redirect_to @summit, notice: 'Summit was successfully created.' }
        #format.json { render :show, status: :created, location: @summit }
      else
        format.html { render :new }
        #format.json { render json: @summit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /summits/1
  # PATCH/PUT /summits/1.json
  def update
    if session[:edit_code].present? && session[:edit_code] == @summit.edit_code
      @summit.currency = "$"
      @summit.location_country = "USA"

      @summit.deadline = create_deadline_json
            
      @summit.published = false
      
      @summit.attributes = summit_params
      
      if @summit.valid?
        @summit.published = true
      end
      
      
      if @summit.save(validate: false)
        # log out && redirect
        if @summit.published
          reset_session
          #render("edit/edit")
          redirect_to @summit
#            format.html { redirect_to @summit, notice: 'Summit was successfully updated.' }
        else
          #@summit.validation_check
          #@summit.errors.add(:name, "roflmao")
          #@summit.valid?
          render "edit/edit"
        end
      else
        render "edit/edit"
      end
    else
      redirect_to @summit
    end
  end

  # DELETE /summits/1
  # DELETE /summits/1.json
  def destroy
    @summit.destroy
    respond_to do |format|
      format.html { redirect_to summits_url, notice: 'Summit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_summit
      @summit = Summit.find(params[:id])
    end
  
    def create_deadline_json
      unencoded = '{ "content": ['
      if(params["deadline"]["dates"].size == 1)
        unencoded += '{ "text": "", "date": "'+ params["deadline"]["dates"][0] + '"} '
      else
        params["deadline"]["labels"].each_with_index do |deadline, index|
          unencoded += '{ "text": "' + deadline + '", "date": "'+ params["deadline"]["dates"][index] + '"},'
        end
      end
      unencoded = unencoded[0..-2]+"]}"
      return unencoded
    end
  

    # Never trust parameters from the scary internet, only allow the white list through.
    def summit_params
      params.require(:summit).permit(:name, :deadline, :application_link, :location_city, :location_state, :location_country, :language, :date_start, :date_end, :cost, :currency, :fields, :idea_stage, :planning_stage, :implementation_stage, :operating_stage, :description, :contact_website, :contact_email, :admin_email, :admin_url)
    end
  
  
    # send out an email with the edit code for the new private summit
    def send_edit_code email, edit_code
    
    @first_name = "lol"
    
    require 'mandrill'  
    m = Mandrill::API.new
    message = {
     :subject=> "Your Summit Edit Code",  
     :from_name=> "Social Summit List",
     :from_email=>"info@summits.social-change.net",
     :to=>[  
       {  
         :email => email
       }  
     ],  
    :html=>render_to_string('emails/new_edit_code', :layout => false) 
    }  
    sending = m.messages.send message  
    puts sending
  end
end
