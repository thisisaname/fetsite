class LvasController < ApplicationController
  # GET /lvas
 before_filter {@toolbar_elements =[]} 
  def index
    @lvas = Lva.all
    
  end

  # GET /lvas/1

  def show
    @lva = Lva.find_by_id(params[:id])
    @toolbar_elements<<{:icon=>:pencil,:text =>I18n.t('common.edit'),:path => edit_lva_path(@lva)}
  end

  # GET /lvas/new
  # GET /lvas/new.json
  def new
    @lva = Lva.new
    modul=Modul.find(params[:modul_id])
    @lva.modul<<modul # 
    
  end

  # GET /lvas/1/edit
  def edit
    @lva = Lva.find(params[:id])
  end

  # POST /lvas
  # POST /lvas.json
  def create
    @lva = Lva.new(params[:lva])
    if @lva.semester.nil?
      for m in @lva.modul
        for mg in m.modulgruppen
          @lva.semester << mg.studium.semester.last
        end
      end
    end
    respond_to do |format|
      if @lva.save
        format.html { redirect_to @lva, notice: 'Lva was successfully created.' }
        
      else
        format.html { render action: "new" }
        
      end
    end
  end

  # PUT /lvas/1
  # PUT /lvas/1.json
  def update
    @lva = Lva.find(params[:id])
    if @lva.semester.nil?
      for m in @lva.modul
        for mg in m.modulgruppen
          @lva.semester << mg.studium.semester.last
        end
      end
      end
    respond_to do |format|
      if @lva.update_attributes(params[:lva])
        format.html { redirect_to @lva, notice: 'Lva was successfully updated.' }
 
      else
        format.html { render action: "edit" }

      end
    end
  end

  # DELETE /lvas/1
  # DELETE /lvas/1.json
  def destroy
    @lva = Lva.find(params[:id])
    @lva.destroy

    respond_to do |format|
      format.html { redirect_to lvas_url }
   
    end
  end
end
