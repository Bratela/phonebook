class ContactsController < ApplicationController
  before_filter :authenticate_user!
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.my_contacts current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)

    #Retorna 404 caso não encontre o contato
    return render_404 unless @contact

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @contact
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])
    return render_404 unless @contact

    respond_to do |format|
      if @contact.save
        format.html { redirect_to(contacts_url, :notice => 'Contact was successfully created.') }
        format.xml  { render :xml => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.xml
  def update
    @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @contact

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to(contacts_url, :notice => 'Contact was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find_by_id_and_user_id(params[:id], current_user.id)
    return render_404 unless @contact

    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url, :notice => 'Contact was successfully deleted.') }
      format.xml  { head :ok }
    end
  end
end
