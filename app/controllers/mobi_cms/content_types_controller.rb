require_dependency "mobi_cms/application_controller"

module MobiCms
  class ContentTypesController < ApplicationController
    SINGLE_ATTRIBUTE_META_DATA = {'name' => "", 'is_required' => false, 'type' => '', 'is_uniq' => false, 'errors' => ""}
    def index
      @content_types = ContentType.all
    end
  

    def show
      @content_type = ContentType.find(params[:id])
    end
  

    def new
      @content_type = ContentType.new(:elements => [SINGLE_ATTRIBUTE_META_DATA])
    end
  
    def edit
      @content_type = ContentType.find(params[:id])
      @content_type.elements = JSON.parse(@content_type.content_type_attributes)
    end
  

    def create
      elements = params.delete(:element)
      @content_type = ContentType.new(:elements => elements, :name => params[:name])
      @content_type.valid?
      if @content_type.valid?
        @content_type.save
        redirect_to content_types_url, :success => "Content type was successfully created."
      else
        render :action => :new
      end
    end
  
    def update
      @content_type = ContentType.find(params[:id])
      @content_type.elements = params.delete(:element)
      @content_type.name = params[:name]
      @content_type.valid?
      if @content_type.valid?
        @content_type.save
        redirect_to content_types_url, notice: 'Content type was successfully updated.' 
      else
        render action: "edit"
      end
    end
  
    # DELETE /content_types/1
    # DELETE /content_types/1.json
    def destroy
      @content_type = ContentType.find(params[:id])
      @content_type.destroy
      redirect_to content_types_url 
    end
    
    def another_element
      @content_type = ContentType.new
    end

  end
end
