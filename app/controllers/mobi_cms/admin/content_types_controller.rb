module MobiCms
  module Admin
  class ContentTypesController < BaseController
    load_and_authorize_resource :class => 'MobiCms::ContentType'


    def index
      @content_types = ContentType.latest
    end
  
    def show
      @content_type = ContentType.find(params[:id])
    end

    def new
      @content_type = ContentType.new(:hashed_elements => { 0 => ContentType::SINGLE_ATTRIBUTE_META_DATA})
    end
  
    def edit
      @content_type = ContentType.find(params[:id])
      @content_type.hashed_elements = JSON.parse(@content_type.content_type_attributes)
    end
  
    def create
      @content_type = ContentType.new(params[:content_type])
      if @content_type.save
        redirect_to mobi_cms.admin_content_types_url, :success => "Content type was successfully created."
      else
        render :action => :new
      end
    end
  
    def update
      @content_type = ContentType.find(params[:id])
      if @content_type.update_attributes(params[:content_type])
        redirect_to mobi_cms.admin_content_types_url, notice: 'Content type was successfully updated.' 
      else
        render action: "edit"
      end
    end
  
    # DELETE /content_types/1
    # DELETE /content_types/1.json
    def destroy
      @content_type = ContentType.find(params[:id])
      @content_type.destroy
      redirect_to mobi_cms.admin_content_types_url, notice: 'Content type was successfully deleted.' 
    end
    
    def another_element
      @content_type = ContentType.new
    end
  end
  end
end
