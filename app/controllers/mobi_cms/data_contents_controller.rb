module MobiCms
  class DataContentsController < MobiCms::ApplicationController
    before_filter :authenticate_cms_user
    before_filter :get_form

    def index
      @content_attributes = JSON.parse(@content_type.content_type_attributes).collect{|title,value_hash| title}
      @data_contents = @content_type.data_contents
    end
  

    def show
      @data_content = DataContent.find(params[:id])
      template = Liquid::Template.parse @content_type.template
      @msg_template = template.render 'data' => JSON.parse(@data_content.values)
    end
  

    def new
      @data_content = @content_type.data_contents.build
    end
  

    def edit
      @data_content = DataContent.find(params[:id])
      @data_content.parse_and_set_attributes(false)
    end
  

    def create
      params_content = params.delete(:data_content)
      @data_content = @content_type.data_contents.build(:contents => params_content)
      @data_content.user_id = mobi_cms_user.id
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
      @content_type = ContentType.where(:id => params[:content_type_id])[0]
      redirect_to mobi_cms.root_url, :notice => "Record not found" and return if @content_type.blank?
    end
  end
end
