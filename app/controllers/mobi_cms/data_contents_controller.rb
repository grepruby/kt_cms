require_dependency "mobi_cms/application_controller"

module MobiCms
  class DataContentsController < ApplicationController
    SINGLE_ATTRIBUTE_META_DATA = {'title' => "", 'unique' => false, 'data_type' => '', 'mendatory' => false, 'errors' => "", 'multi_options' => ''}
    before_filter :get_form

    def index
      @data_contents = @content_type.data_contents

    end
  

    def show
      @data_content = DataContent.find(params[:id])
    end
  

    def new
      @data_content = @content_type.data_contents.build
    end
  

    def edit
      @data_content = DataContent.find(params[:id])
      @data_content.parse_and_set_attributes
    end
  

    def create
      
      params_content = params.delete(:data_content)
      @data_content = @content_type.data_contents.build(:contents => params_content)
      if @data_content.save
        redirect_to content_type_data_contents_path(@content_type), notice: 'Data content was successfully created.'
      else
        render action: "new"
      end
    end
  

    def update
      params_content = params.delete(:data_content)
      @data_content = DataContent.find(params[:id])
      @data_content.contents = params_content
      if @data_content.update_attributes(params[:data_content])
        redirect_to content_type_data_contents_path(@content_type), notice: 'Data content was successfully updated.'
      else
        render action: "edit"
      end
    end
  

    def destroy
      @data_content = DataContent.find(params[:id])
      @data_content.destroy
      redirect_to content_type_data_contents_path(@content_type), notice: 'Data content was successfully deleted.'
    end

    private

    def get_form
      @content_type = ContentType.find(params[:content_type_id])
      redirect_to content_types_path and return if @content_type.blank?
    end
  end
end
