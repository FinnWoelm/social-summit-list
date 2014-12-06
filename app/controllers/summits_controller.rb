class SummitsController < ApplicationController
  before_action :set_summit, only: [:show, :edit, :update, :destroy]

  # GET /summits
  # GET /summits.json
  def index
    @summits = Summit.all.order(:date_start)
  end

  # GET /summits/1
  # GET /summits/1.json
  def show
  end

  # GET /summits/new
  def new
    @summit = Summit.new
    send_edit_code
  end

  # GET /summits/1/edit
  def edit
  end

  # POST /summits
  # POST /summits.json
  def create
    @summit = Summit.new(summit_params)
    
    @summit.currency = "$"
    @summit.location_country = "USA"
    
    @summit.deadline = create_deadline_json
    @summit.admin_email = "test"
    @summit.admin_url = "test"
    
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
    respond_to do |format|
      if @summit.update(summit_params)
        format.html { redirect_to @summit, notice: 'Summit was successfully updated.' }
        #format.json { render :show, status: :ok, location: @summit }
      else
        format.html { render :edit }
        #format.json { render json: @summit.errors, status: :unprocessable_entity }
      end
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
  
  def send_edit_code
    require 'mandrill'  
    m = Mandrill::API.new
    message = {
     :subject=> "Your Social Summit Edit Code",  
     :from_name=> "Social Summit List",
     :from_email=>"info@summits.social-change.net",
     :to=>[  
       {  
         :email=> "finn.woelm@gmail.com",  
         :name=> "Finn"  
       }  
     ],  
    :html=>render_to_string('emails/new_edit_code', :layout => false) 
    }  
    sending = m.messages.send message  
    puts sending
  end
end
